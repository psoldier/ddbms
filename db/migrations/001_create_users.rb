Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username, :null => false
      Text :crypted_password, :null => false
      String :name
      TrueClass :admin, :default => false
      DateTime :created_at
      DateTime :updated_at
    end
  end
end