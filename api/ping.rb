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

      case params[:state]
      when "start"
        state = "opened"
      when "stop"
        state = "tab deactivated"
      when "destroy"
        state = "tab closed"
      when "save"
        state = "saved"
      end

      domain=Domain.first_or_create({:domain=>params[:domain]})
      assignee = domain.assignees.first_or_create({:id=>params[:assignee_id]},{:email=>params[:email]})
      ping = assignee.pings.create(:state=>state, :ticket_id=>params[:ticket_id],:domain_id=>domain.id)
      {id:ping.id}
    end

  end

end
