#ping.rb
class Api

  version 'v1', using: :path
  format :json

  resource :ping do

    desc "Return a ping."
    params do
      requires :id, type: Integer, desc: "Ping id."
    end
    route_param :id do
      get do

        {id: Ping.get(params[:id]).id,
         test: ENV['TEST']}
      end
    end

  end
end
