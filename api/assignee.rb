#assignee.rb
class Api

  version 'v1', using: :path
  format :json

  helpers do


    def authenticate!(token)
      error!('401 Unauthorized', 401) unless Account.first(:api_key=>token)
    end
  end

  resource :assignee do

    desc "Return a Assignee."
    params do
      requires :id, type: Integer, desc: "Assignee id."
      requires :token
    end
    route_param :id do
      get do
        authenticate!(params[:token])
        assignee = Assignee.get(params[:id])

        {id: assignee.id,
         selected_state: assignee.selected_state,
         last_ping: assignee.pings.last.created_at,
         ticket: assignee.pings.last.ticket_id}
      end
    end

    desc "Updates a selected_state."
    params do
      requires :selected_state, type: String, desc: "Your selected state."
    end
    route_param :id do
      post do
        authenticate!(params[:token])

        assignee = Assignee.get(params[:id])

        assignee.selected_state = params[:selected_state]

        if assignee.save
          {result:"success"}
        else
          {result:"failed"}
        end

      end
    end

  end

end
