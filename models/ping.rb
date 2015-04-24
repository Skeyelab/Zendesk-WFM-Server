class Ping
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :ticket_id, Integer
  property :state, String

  property :created_at, DateTime

  belongs_to :assignee
  belongs_to :domain

end
