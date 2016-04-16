module ValProject
  class Profile < Sequel::Model
    def public_date_of_birth?
      public_date_of_birth
    end
  end
end
