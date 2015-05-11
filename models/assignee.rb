class Assignee
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String, :required => true, :index => true

  property :selected_state, Enum[ "active", "inactive"], :default  => "inactive"

  belongs_to :domain
  has n, :pings


  def last_ping
    return time_diff(Time.now,Time.parse(pings.last.created_at.to_s))
  end

end
