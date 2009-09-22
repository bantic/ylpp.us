class Click < ActiveRecord::Base
  belongs_to :shortening, :counter_cache => :clicks
  
  def self.track!(hash_key)
    if shortening = Shortening.find_by_hash_key(hash_key)
      self.create(:shortening => shortening)
    end
  end
end
