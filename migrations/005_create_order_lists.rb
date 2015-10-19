Sequel.migration do
  change do
    create_table(:order_lists) do
      primary_key :id, unique: true
      Integer :place_id, null: false
      Boolean :closed, null: false, default: false
      Date :created_at
    end
  end
end
