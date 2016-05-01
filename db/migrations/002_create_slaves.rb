Sequel.migration do
  change do
    create_table(:slaves) do
      primary_key :id
      String :adapter, :null => false
      String :host, :null => false
      String :host_name, :null => false
      String :host_password, :null => false
      String :username, :null => false
      String :password, :null => false
      String :database, :null => false
      String :master_host, :null => false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
