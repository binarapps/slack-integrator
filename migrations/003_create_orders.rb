Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id, unique: true
      Integer :order_list_id
      String :item, null: false
      String :description
      String :user_name
    end
  end
end
