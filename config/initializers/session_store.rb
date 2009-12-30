# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_matze-msh_session',
  :secret      => 'a6562c11429bc1ce4a6de06ee3e2cd3bdb33d59ca0261fa6d7d4cbe5f8da8eff8fbb8657a8be9ac66133d41f1267f2e11fbdf5f0db547fa57703729dfd2ab6bd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
