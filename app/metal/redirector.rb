# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Redirector
  def self.call(env)
    # env.each {|k,v| puts "#{k}: #{v}"}
    if env["PATH_INFO"] =~ /^\/([a-zA-Z0-9-]*)\/?$/
      if url = MONETA[$1]
        return [301, {"Location" => url}, []]
      end
    end

    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end
end
