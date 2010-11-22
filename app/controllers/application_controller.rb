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
      redirect_to projects_url
    end
  end
  
  def get_client token, secret
    TwitterOAuth::Client.new(
      :consumer_key => "u1rKrNjTownQZO2KfP4yZw",
      :consumer_secret => "gNIh6myFIjunLGSYLafcu12lSb3fUnqFGIZ71IOw",
      :token => token,
      :secret => secret)
  end

  def freq_count doc, size
    fh = Hash.new(0)
    words = doc.split(' ').select{|w| w.size > size}.map{|w| w.chomp.downcase}
    words.each{ |w|
      fh[w] = fh[w] + 1
    }
    return fh
  end
  
  def do_semantic docs, freqs
    semantic_hash = Hash.new
    docs.each do |tweet|
      words = tweet.split(' ').map{|x| x.chomp.downcase}
      words.each do |w1|
        words.each do |w2|
          if not semantic_hash[w1].nil?
            semantic_hash[w1][w2] = semantic_hash[w1][w2] + (1.0 / freqs[w2].to_f)
          else
            semantic_hash[w1] = Hash.new(0.0)
            semantic_hash[w1][w2] = (1.0 / freqs[w2].to_f)
          end
        end
      end
    end
    return semantic_hash
  end
  
  
  def ego_words
    ["I", "We", "my", "myself", "checking in", "facebook", "check in", "log in",
      "breakfast", "lunch", "dinner", "I'm"].map{|x| x.downcase}
  end

end
