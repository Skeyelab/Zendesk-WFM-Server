class Assignee
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String, :required => true, :index => true

  property :selected_state, String, :default  => "inactive"

  belongs_to :domain
  has n, :pings
end
