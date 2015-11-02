Sequel.migration do
  up do
    add_column :users, :issues, Integer, default: 0
  end

  down do
    drop_column :users, :issues, Integer, default: 0
  end
end
