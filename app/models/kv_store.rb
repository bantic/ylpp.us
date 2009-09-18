require 'moneta/tyrant'
require 'singleton'
class KVStore
  include Singleton
  
  def moneta
    @moneta ||= load_moneta
  end
  
  def load_moneta
    Moneta::Tyrant.new(YAML.load_file(Rails.root.join("config","moneta.yml"))[Rails.env])
  end
  
  # failover/reconnect
  def method_missing(meth, *args, &blck)
    begin
      if moneta.respond_to?(meth)
        moneta.send(meth, *args, &blck)
      else
        super
      end
    rescue RuntimeError => e
      case e.message
      when /couldn't connect to tyrant/
        @moneta = load_moneta
        retry
      end
    end
  end
end