class Ping
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :ticket_id, Integer
  property :state, String

  property :created_at, DateTime, :index => true
  property :timestamp, DateTime, :index => true

  belongs_to :assignee
  belongs_to :domain

  def self.perform(params)

    case params["state"]
    when "start"
      state = "opened"
    when "stop"
      state = "tab deactivated"
    when "destroy"
      state = "tab closed"
    when "save"
      state = "saved"
    end

    domain=Domain.first_or_create({:domain=>params["domain"]})
    assignee = domain.assignees.first_or_create({:id=>params["assignee_id"]},{:email=>params["email"]})
    ping = assignee.pings.create(:state=>state, :ticket_id=>params["ticket_id"],:domain_id=>domain.id,:timestamp=>params["timestamp"])
  end

end
