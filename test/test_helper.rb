ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require_relative 'mock.rb'
require 'vcr'

VCR.configure do |c|
 c.cassette_library_dir = 'test/fixtures/vcr_cassettes'

 c.hook_into :webmock
 c.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding.name == 'ASCII-8BIT' ||
    !http_message.body.valid_encoding?
 end

 c.default_cassette_options = { :serialize_with => :json }
 c.before_record do |r|
   r.request.headers.delete("Authorization")
 end
end

class ActiveSupport::TestCase
  fixtures :all
end
