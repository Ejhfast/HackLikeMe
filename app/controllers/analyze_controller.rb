class AnalyzeController < ApplicationController
  before_filter :login_required
  
  def freq
    count = params[:count] || 5
    @auth = current_user.authorizations.first
    
    client = get_client(@auth.token, @auth.secret)
    testr = client.user_timeline(:count => count).map{|x| x['text']}
    
    @freqs = freq_count( testr.flatten.join(' '), 3 )
    @highest_keys = @freqs.keys.sort_by{|key| @freqs[key] * -1}
    
    render :json => @freqs
  end
  
  def ego
    count = params[:count] || 5
    @auth = current_user.authorizations.first
    name = current_user.name
    
    client = get_client(@auth.token, @auth.secret)
    timeline = client.user_timeline(:count => count).map{|x| x['text']}
    
    freqs = freq_count( timeline.flatten.join(' '), 0 )
    wrds = freqs.select{|k,v| 
      ["i","me","my","we","myself"].include?(k.downcase) ||
      (name.split(' ').select{|p| k.include?(p.downcase) }.compact.size >= 1) }
    score = 0
    wrds.each {|k,v| score += v}
    @egoscore = { :name => name, :score => score, :freqs => wrds}
    
    render :json => @egoscore
  end
end
