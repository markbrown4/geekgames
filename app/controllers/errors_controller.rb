class ErrorsController < ApplicationController
  respond_to :json

  def log
    ErrorLog.create(params[:error])
    render :json => { :that_makes_me => ":'(" }.to_json, :status => 200
  end

end
