class Shortening < ActiveRecord::Base
  validates_presence_of :url
  after_create :hash_it
  
  def hash
    (id + 1_000_000).to_s(32)
  end
  
  private
  
  def hash_it
    MONETA[hash] = url
  end
end
