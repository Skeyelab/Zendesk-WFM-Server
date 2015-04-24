class Domain
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :domain, String

  has n, :assignees
end
