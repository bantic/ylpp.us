class Click < ActiveRecord::Base
  belongs_to :shortening, :counter_cache => true
  
  before_create :set_referer_host
  
  def self.track!(hash_key, env)
    if shortening = Shortening.find_by_hash_key(hash_key)
      self.create(:shortening => shortening,
                  :referer    => env['HTTP_REFERER'],
                  :user_agent => env['HTTP_USER_AGENT'],
                  :remote_ip  => env['REMOTE_ADDR'])
    end
  end
  
  private
  
  def set_referer_host
    return unless referer.present?
    
    self.referer_host = URI.parse(referer).host
  rescue => e
    nil
  end
end
