migration 4, :create_domains do
  up do
    create_table :domains do
      column :id, Integer, :serial => true
      column :domain, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :domains
  end
end
