class Ticketping
  include DataMapper::Resource
  include Backburner::Queue
  queue_priority 100
  queue "ticket-pings"

  # property <name>, <type>
  property :id, Serial
  property :ticket_id, Integer
  property :status, String
  property :transaction_handle_time, Integer
  property :country, String
  property :line_of_business, String

  property :created_at, DateTime, :index => true
  property :timestamp, DateTime, :index => true

  belongs_to :domain

  def self.perform(params)

    domain=Domain.first_or_create({:domain=>params["domain"]})
    ticketping = domain.ticketpings.first_or_create(
      {:ticket_id=>params["ticket_id"]},
      {
        :created_at=>params["created_at"],
        :status=>params["status"],
        :transaction_handle_time=>params["transaction_handle_time"],
        :country=>params["country"],
        :line_of_business=>params["line_of_business"],
        :timestamp=>params["timestamp"]
    })
  end

end
