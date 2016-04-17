module ValProject
  class Session
    class Destroy < Trailblazer::Operation
      def model!(params)
        Session.first id: params[:session].id
      end

      def process(_)
        model.delete
      end
    end
  end
end
