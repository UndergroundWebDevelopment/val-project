require "session/operations"

class UserFactory
  def self.default(args = {})
    password = args[:password] || Faker::Internet.password
    default = {
      email: Faker::Internet.email,
      password: password,
      confirm_password: password,
    }

    final = default.merge(args)

    Session::Signup[user: final].model
  end
end
