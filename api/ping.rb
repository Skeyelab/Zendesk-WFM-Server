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
        ping = Ping.get(params[:id])

        {id: ping.id,
         state: ping.state}
      end
    end

    desc "Create a ping."
    params do
      requires :state, type: String, desc: "Your state."
    end
    post do
      ping = Ping.create(:state=>params[:state], :domain => params[:domain],:assignee_id => params[:assignee_id], :ticket_id=>params[:ticket_id])
      {id:ping.id}
    end

  end

end
