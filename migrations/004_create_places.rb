Sequel.migration do
  change do
    create_table(:places) do
      primary_key :id, unique: true
      String :name, null: false
      String :full_name, null: false
      String :schema
      String :phone, null: false
      String :menu
    end
  end
end
