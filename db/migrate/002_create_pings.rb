migration 2, :create_pings do
  up do
    create_table :pings do
      column :id, Integer, :serial => true
      column :assignee_id, DataMapper::Property::Integer
      column :ticket_id, DataMapper::Property::Integer
      column :state, DataMapper::Property::String, :length => 255
      column :domain, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :pings
  end
end
