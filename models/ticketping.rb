class Ticketping
  include DataMapper::Resource
  include Backburner::Queue
  queue_priority 100
  queue "ticket-pings"

  # property <name>, <type>
  property :id, Serial
  property :ticket_id, Integer
  property :status, String

  property :created_at, DateTime, :index => true
  property :timestamp, DateTime, :index => true

  belongs_to :domain

  def self.perform(params)

    domain=Domain.first_or_create({:domain=>params["domain"]})
    ticketping = domain.ticketpings.first_or_create({:ticket_id=>params["ticket_id"]},{:created_at=>params["created_at"],:status=>params["status"]})
  end

end
