# Load the rails application
require File.expand_path('../application', __FILE__)

require 'pony'

# Initialize the rails application
TennisLadder::Application.initialize!

Pony.options = {
  :to => 'dmhope1106@gmail.com',
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'davidstennisladder@gmail.com',
    :password             => '##F3rgusH0p3##',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  }
}