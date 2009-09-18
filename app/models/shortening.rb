class Shortening < ActiveRecord::Base
  validates_presence_of :url
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  after_create :save_hash
  
  def hash
    (id + 1_000_000).to_s(32)
  end
  
  def to_param
    hash
  end
  
  def self.find_by_hash(hash)
    find(hash.to_i(32) - 1_000_000)
  end
  
  private
  
  def save_hash
    KVStore.instance[hash] = url
  end
end
