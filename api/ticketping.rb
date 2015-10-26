#ticketping.rb
class Api

  version 'v1', using: :path
  format :json

  resource :ticketping do

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

    post do
      params.timestamp = Time.now
      if params["transaction_handle_time"] == ""
        params["transaction_handle_time"] = 0
      end
      Backburner.enqueue Ticketping, params

    end

  end

end
