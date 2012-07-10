class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def filter_attr attribute_hash, valid_attributes
    attribute_hash.dup.select { |attr, value| valid_attributes.collect(&:to_s).include?(attr) }
  end
  
  def after_sign_in_path_for resource
    unless resource.username.present?
      profile_path
    else
      super resource
    end
  end

end
