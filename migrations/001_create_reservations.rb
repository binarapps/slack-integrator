Sequel.migration do
  change do
    create_table(:reservations) do
      primary_key :id, unique: true
      Date :reserved_at, null: false
      String :from, null: false
      String :to, null: false
    end
  end
end
