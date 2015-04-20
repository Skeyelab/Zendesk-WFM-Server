class Ping
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :assignee_id, Integer
  property :ticket_id, Integer
  property :state, String
  property :domain, String

  property :created_at, DateTime
end
