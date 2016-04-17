module ValProject
  class User < Sequel::Model
    # Password setter uses BCrypt to generate a password hash and store it in
    # the model. BCrypt::Password will include a randomized salt in the
    # password, for added security. See
    # https://github.com/codahale/bcrypt-ruby#how-to-use-bcrypt-ruby-in-general
    def password=(new_password)
      self.password_hash = BCrypt::Password.create(new_password)
    end

    # Returns a boolean of whether the given password is this user's password,
    # used to authenticate the user:
    def password_is?(password)
      BCrypt::Password.new(password_hash) == password
    end
  end
end
