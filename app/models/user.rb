class User < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  has_many :authentications, :dependent => :destroy

  validates :username,  :uniqueness => true, :allow_blank => true
  validates :email,     :presence => true, :if => :email_required?
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :country, :opt_in
  
  after_create :send_to_campaign_monitor, :if => :opt_in
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def current_round
    round = rounds.last
    round = self.rounds.create() if !round.present? || round.complete?
    round
  end
  
  def best_round()
    rounds.order('total_score desc').limit(1).first
  end
  
  def self.search(search, page)
    paginate :per_page => 20, :page => page,
             :conditions => ['username like ?', "%#{search}%"],
             :order => 'username'
  end
  
  def name
    if self.first_name.present?
      "#{first_name} #{last_name}"
    elsif self.username.present?
      self.username
    else
      self.email[/[^@]+/]
    end
  end
  
  def send_to_campaign_monitor
    api_key = APP_CONFIG['campaign_monitor']['api_key']
    list_id = APP_CONFIG['campaign_monitor']['list_id']
    domain = "api.createsend.com"
    path = "/api/api.asmx/Subscriber.Add?ApiKey=#{api_key}&ListID=#{list_id}&Email=#{email}&Name=#{name}"
    http = Net::HTTP.new(domain, 80)
    
    # logger.debug("CAMPAIGN MONITOR: #{domain}#{path}")
    http.get(path)
  end

  # Auth
  def apply_authentication(params = {})
    case params['provider']
      when "twitter"
        name = params['info'].try(:[], 'name')
        self.first_name = name.split(" ")[0] if first_name.blank? && name
        self.last_name = name.split(" ")[1] if last_name.blank? && name
      when "facebook"
        self.email = params['extra'].try(:[], 'raw_info').try(:[], 'email') if email.blank?
        self.first_name = params['extra'].try(:[], 'raw_info').try(:[], 'first_name') if first_name.blank?
        self.last_name = params['extra'].try(:[], 'raw_info').try(:[], 'last_name') if last_name.blank?
    end

    authentication = authentications.build(
      :provider => params['provider'],
      :uid      => params['uid'],
      :token    => params['credentials'].try(:[], 'token'),
      :extra    => params['extra']
    )
    authentication.save if persisted?
  end

  def password_required?
    (authentications.empty? || !password.blank?) &&
    (!persisted? || !password.nil? || !password_confirmation.nil?)
  end

  def facebook
    return false unless self.authentications.find_by_provider('facebook')

    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token).fetch
  end

  private
  def email_required?
    authentications.empty?
  end
end
