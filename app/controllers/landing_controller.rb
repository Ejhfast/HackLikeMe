class LandingController < ApplicationController
  def login
    render :text => "You must first <a href='/auth/twitter'>log in!</a>"
  end

end
