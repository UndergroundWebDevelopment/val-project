module ValProject
  class Session < Sequel::Model
    many_to_one :user, class: :'ValProject::User', order: :id, key: :owned_by_user_id
  end
end
