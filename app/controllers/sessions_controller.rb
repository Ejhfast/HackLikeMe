class SessionsController < ApplicationController
  
  
  
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth)
    end
    self.current_user = @auth.user
    
    render :text => "Logged In!"
  end
  
  def destroy
    sign_out
    render :text => "Logged Out!"
  end
  
end
