# See https://github.com/codahale/bcrypt-ruby

require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence: true, uniqueness: true

  after_destroy :ensure_an_admin_remains

  has_secure_password

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last"
    end
  end
end
