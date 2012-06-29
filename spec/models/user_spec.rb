require 'spec_helper'

describe User do

  describe '#email_required?' do
    it "defaults to true for new records" do
      User.new.send(:email_required?).should be_true
    end

    it "returns false if a new record has at least one authentication" do
      user = User.new
      user.stub_chain(:authentications, :empty? => false)

      user.send(:email_required?).should be_false
    end
  end

end