migration 3, :create_assignees do
  up do
    create_table :assignees do
      column :id, Integer, :serial => true
      
    end
  end

  down do
    drop_table :assignees
  end
end
