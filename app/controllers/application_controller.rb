# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def get_hashes_for_user
    hashes = (cookies['hashes'] || "").split(",")
  end
  
  def save_hash_for_user(hash)
    hash = hash.is_a?(Shortening) ? hash.hash_key : hash
    hashes = get_hashes_for_user
    hashes.unshift(hash)
    cookies['hashes'] = {
       :value => hashes.join(","),
       :expires => 1.year.from_now,
       :domain => DOMAIN_NAME
     }
  end
end
