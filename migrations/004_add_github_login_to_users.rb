Sequel.migration do
  up do
    add_column :users, :github_login, String
  end

  down do
    drop_column :users, :github_login, String
  end
end
