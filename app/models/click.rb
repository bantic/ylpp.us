class Click < ActiveRecord::Base
  belongs_to :shortening
  
  before_create :set_referer_host
  before_create :set_location_from_ip
  before_create :set_bot_status
  
  def self.bot?(user_agent)
    return false if user_agent.nil?
    
    return true if user_agent =~ /spider|bot|crawler|curl|Twingly Recon|ThingFetcher|MetaURI|PostRank/i
    return false
  end
  
  def self.track!(hash_key, env)
    if shortening = Shortening.find_by_hash_key(hash_key)
      self.create(:shortening => shortening,
                  :referer    => env['HTTP_REFERER'],
                  :user_agent => env['HTTP_USER_AGENT'],
                  :remote_ip  => env['REMOTE_ADDR'])
    end
  end
  
  def location_string
    return "" unless self.country
    
    if self.region
      "#{self.city}, #{self.region} #{self.country}"
    else
      "#{self.city} #{self.country}"
    end
  end
  
  protected
  
  def after_create
    shortening.increment!(:clicks_count) unless bot?
    shortening.increment!(:all_clicks_count)
  end
  
  def after_destroy
    shortening.decrement!(:clicks_count) unless bot?
    shortening.decrement!(:all_clicks_count)
  end
  
  private
  
  def set_referer_host
    return unless referer.present?
    
    self.referer_host = URI.parse(referer).host
    true
  rescue => e
    true
  end
  
  def set_location_from_ip
    return unless remote_ip.present?
    return if remote_ip =~ /^(127|0)\./
    
    geoip_data = GEO_IP_DB.city(remote_ip)
    
    self.country = geoip_data[4]
    self.region  = geoip_data[6]
    self.city    = geoip_data[7]
    true
  end
  
  def set_bot_status
    self.bot = self.class.bot?(self.user_agent)
    true
  end  
end
