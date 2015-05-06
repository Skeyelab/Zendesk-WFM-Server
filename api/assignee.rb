#assignee.rb
class Api

  version 'v1', using: :path
  format :json

  resource :assignee do

    desc "Return a Assignee."
    params do
      requires :id, type: Integer, desc: "Assignee id."
    end
    route_param :id do
      get do
        assignee = Assignee.get(params[:id])
        {id: assignee.id,
         selected_state: assignee.selected_state}
      end
    end

    desc "Updates a selected_state."
    params do
      requires :selected_state, type: String, desc: "Your selected state."
    end
    route_param :id do
      post do

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
