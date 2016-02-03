ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Sets up all fixtures in test/fixtures/*.yml for all tests in
  # alphabetical order.
  # Note: You'll currently still have to declare fixtures explicitly in
  # integration tests -- they do not yet inherit this setting.
  fixtures :all

  # Adds more helper methods to be used by all tests here ...
  def login_as(user)
    session[:user_id] = users(user).id
  end

  def logout
    session.delete :user_id
  end

  def setup
    login_as :dave if defined? session
  end
end
