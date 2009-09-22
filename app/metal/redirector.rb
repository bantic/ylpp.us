# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Redirector
  def self.call(env)
    # env.each {|k,v| puts "#{k}: #{v}"}
    if env["PATH_INFO"] =~ /^\/([a-zA-Z0-9-]*)\/?$/
      if url = MONETA[$1]
        begin
          Click.async_send(:track!, $1, {"HTTP_REFERER"    => env['HTTP_REFERER'],
                                         "HTTP_USER_AGENT" => env["HTTP_USER_AGENT"],
                                         "REMOTE_ADDR"     => env['REMOTE_ADDR']})
        rescue => e
          Rails.logger.info("Failed to track click for hash_key #{$1}: #{e.message}")
        end
        return [301, {"Location" => url}, []]
      end
    end

    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end
end