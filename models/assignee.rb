class Assignee
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String
end
