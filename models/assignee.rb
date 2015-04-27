class Assignee
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String, :required => true, :index => true


  belongs_to :domain
  has n, :pings
end
