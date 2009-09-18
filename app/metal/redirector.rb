# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Redirector
  def self.call(env)
    # env.each {|k,v| puts "#{k}: #{v}"}
    if env["PATH_INFO"] =~ /^\/([\d\w][^\/]*)\/?$/
      if url = KVStore.instance[$1]
        return [301, {"Location" => url}, []]
      end
    end

    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end
end
