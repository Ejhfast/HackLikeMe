class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in?
  
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def sign_out
    @current_user = nil
    session[:user_id] = nil
  end
  
  def login_required
    if not current_user
      redirect_to login_url
    end
  end
  
  def get_client token, secret
    TwitterOAuth::Client.new(
      :consumer_key => "TLC5QDn0kuXJFl41weM96Q",
      :consumer_secret => "KTb9bIHeAcrrOIjF2g96huSpMQaWUgPIEj1qOB0wOQQ",
      :token => token,
      :secret => secret)
  end

  def freq_count doc, size
    fh = Hash.new(0)
    words = doc.split(' ').select{|w| w.size > size}
    words.each{ |w|
      fh[w] = fh[w] + 1
    }
    return fh
  end

end
