# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shorty_session',
  :secret      => 'f1ab7cef4d6f4b0326834144231a0c9ae81ef69ec28cb2de3714f7f88f2dc19d4328b8d9aa754b83d2788456d6c02baa42162247e55ab06421c342df71cb4e05'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
