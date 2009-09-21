class Shortening < ActiveRecord::Base
  validates_presence_of :url
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :message => "doesn't seem right.", :on => :create
  validates_format_of :custom_hash, :with => /[a-zA-Z0-9-]/, :allow_blank => true, :on => :create, :message => "can only use alphanumeric characters (and -)."
  
  validate :url_is_not_oroboros
  
  before_create :assign_hash
  after_create :save_hash_to_kv_store
  
  attr_accessor :custom_hash
  attr_protected :hash_key, :clicks, :custom

  HASH_CHARS = ('a'..'z').to_a + ("A".."Z").to_a + ("0".."9").to_a
  
  def to_param
    hash_key
  end
  
  private

  def self.get_hash(length=2,tries=2)
    hash_ar = []
    length.times {hash_ar << HASH_CHARS[rand(HASH_CHARS.length)]}
    if Shortening.exists?(:hash_key => hash_ar.join)
      tries == 0 ? get_hash(length + 1) : get_hash(length, tries - 1)
    else
      return hash_ar.join
    end
  end
  
  def assign_hash
    if self.custom_hash.present?
      if Shortening.exists?(:hash_key => self.custom_hash)
        errors.add_to_base("someone is already using the custom url '#{self.custom_hash}'. The chances of that happening randomly are about a billion to one. Maybe you're just unlucky.")
        return false
      else
        self.hash_key = self.custom_hash
        self.custom = true
      end
    else
      self.hash_key = self.class.get_hash
    end
  end
  
  def url_is_not_oroboros
    if URI.parse(url).host == DOMAIN_NAME
      errors.add(:url, "can't include #{DOMAIN_NAME}. infinite recursion alert.")
    end
  end
  
  def save_hash_to_kv_store
    puts "hash key: #{self.hash_key}. #{self.hash_key.class}. url #{self.url}. #{self.url.class}"
    MONETA[self.hash_key] = self.url
  end
end
