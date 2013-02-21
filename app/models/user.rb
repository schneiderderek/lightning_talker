require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username
  attr_accessor :password

  validates :password, presence: true, on: :create
  validates :password, confirmation: true, length: {minimum: 6}, if: ->(u){ u.password.present? }
  validates :username, presence: true, length: {in: 2..20}, uniqueness: true

  before_save :encrypt_password

  def self.authenticate(username, password)
    return nil if username.blank? || password.blank?

    user = where(username: username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
