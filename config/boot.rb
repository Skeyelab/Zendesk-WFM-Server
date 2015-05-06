# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

Dotenv.load ".env.#{Padrino.env}"

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
  Padrino.dependency_paths << Padrino.root('api/*.rb')
  require 'html/table'
  include HTML
  require 'will_paginate'
  require 'will_paginate/data_mapper'
  require 'will_paginate/view_helpers/sinatra'
  include WillPaginate::Sinatra::Helpers
  WillPaginate.per_page = 100



  Backburner.configure do |config|
    config.beanstalk_url    = ["beanstalk://"+ENV['BEANSTALK_HOST']+":11300"]
    config.tube_namespace   = ENV['BEANSTALK_TUBE_NAMESPACE']
    config.on_error         = lambda { |e| puts e }
    config.max_job_retries  = 3 # default 0 retries
    config.retry_delay      = 2 # default 5 seconds
    config.default_priority = 65536
    config.respond_timeout  = 300
    config.default_worker   = Backburner::Workers::ThreadsOnFork
    config.logger           = Logger.new(STDOUT)
    config.primary_queue    = "wfmserver-jobs"
    config.priority_labels  = { :custom => 50, :useless => 1000 }
  end

  def generate_activation_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end


end
##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  if ENV["REDISCLOUD_URL"]
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    Resque.redis = $redis
  end

  DataMapper.finalize
end

Padrino.load!
