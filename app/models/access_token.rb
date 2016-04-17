module ValProject
  class AccessToken < Sequel::Model
    many_to_one :user, class: :'ValProject::User'
  end
end
