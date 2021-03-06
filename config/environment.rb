# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Check if RRDTool is installed
rrd_parts = `rrdtool`.split

if rrd_parts[0] == nil or rrd_parts[0] != "RRDtool"
  puts "ERROR: YOU NEED TO INSTALL RRDTOOL! (i.e. aptitude install rrdtool)"
  exit
end

SP_VERSION = "0.3-dev"
SP_HOST = `uname -snrm`.chop
RRDTOOL_VERSION = rrd_parts[1]
RRDTOOL_PATH = `which rrdtool`.chop

# Get the git revision if this is a development version
if SP_VERSION.include? "dev"
  SP_DEV = true
  SP_GIT_REV = " #{`git describe --always`}"
else
  SP_DEV = false
  SP_GIT_REV = nil
end

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  config.gem "mysql"
  config.gem "xmpp4r"
  config.gem "oauth"
  config.gem "json"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  #config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_scopeport-interface-web_session',
    :secret      => '6128f43f12fc21014b979a1332f8acef6d699d1a572b769cb5b7d3e4765c027473cc54e07600a6bb389f59290c4fd7b108d05735ca1fc23db09af4bafb44cd81'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  
end

require "will_paginate" 
