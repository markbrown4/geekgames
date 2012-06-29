class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def filter_attr attribute_hash, valid_attributes
    attribute_hash.dup.select { |attr, value| valid_attributes.collect(&:to_s).include?(attr) }
  end

end
