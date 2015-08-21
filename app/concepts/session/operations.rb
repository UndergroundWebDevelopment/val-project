module Session
  class Signup < Trailblazer::Operation
    include CRUD
    model User, :create

    contract do
      property :email
      property :password, virtual: true
      property :confirm_password, virtual: true

      validates :email, :password, :confirm_password, presence: true
      validate :password_ok?

      def password_ok?
        return unless email and password
        return if password == confirm_password 
        errors.add(:password, "Passwords don't match")
      end
    end

    def process(params)
      validate(params[:user]) do
        create!
        contract.save
      end
    end

    def create!
      auth = Tyrant::Authenticatable.new(contract.model)
      auth.digest!(contract.password)
      auth.confirmed!
      auth.sync
    end
  end

  class SignIn < Trailblazer::Operation
    contract do
      property :email,        virtual: true
      property :password,     virtual: true
      validates :email, :password, presence: true
      validate :password_ok?

      attr_reader :user

      private

      def password_ok?
        return if email.blank? || password.blank?
        @user = User.find_by(email: email)
        errors.add(:password, "Wrong password") unless @user &&
          Tyrant::Authenticatable.new(@user).digest?(password)
      end
    end

    # Need a model, but it will never be updated (properties are all virtual)
    def model
      @model ||= User.new
    end

    def process(params)
      validate(params[:session]) do |contract|
        @model = contract.user
      end
    end
  end

  class SignOut < Trailblazer::Operation
    def process(params)
      # No-op, all logic happens in the controller, killing the session.
      # Operation exists to serve as a hook for future "on sign out" logic.
    end
  end
end
