class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  
  def create
    code=params["code"]
    
    resp=Faraday.post("https://github.com/login/oauth/access_token") do |req|
      client_id=ENV["GITHUB_CLIENT_ID"]
      client_secret=ENV["GITHUB_CLIENT_SECRET"]
      req.params["client_id"]=client_id
      req.params["client_secret"=]=client_secret
      req.params["code"]=code
    end
    
    
    session[:token]=resp["access_token"]
    redirect_to root_path
  end
end