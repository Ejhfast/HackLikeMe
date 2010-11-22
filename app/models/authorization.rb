class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_from_hash(hash)
    auth = find_by_provider_and_uid(hash['provider'], hash['uid'])
    # update token / secret
    #auth.token = hash['credentials']['token']
    #auth.secret = hash['credentials']['secret']
    #auth.save
    return auth
  end
  
  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create( :user => user, 
                          :uid => hash['uid'], 
                          :provider => hash['provider'], 
                          :token => hash['credentials']['token'],
                          :secret => hash['credentials']['secret'])
  end
  
end
