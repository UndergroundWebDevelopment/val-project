module ValProject
  class Profile
    class Update < Create
      def model!(params)
        if params[:id] =~ UUID_REGEX
          Profile.first! id: params[:id]
        else
          Profile.first! slug: params[:id]
        end
      end
    end
  end
end
