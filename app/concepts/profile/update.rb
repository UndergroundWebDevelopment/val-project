module ValProject
  class Profile
    class Update < Create
      def model!(params)
        Profile[params[:id]]
      end
    end
  end
end
