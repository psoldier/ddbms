Sequel::Model.plugin :validation_class_methods
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :nested_attributes
Sequel::Model.plugin :association_dependencies
Sequel::Database.extension :pagination
Sequel::Model.plugin :timestamps
Sequel::Model.plugin :json_serializer

PER_PAGE = 25

module Sequel
  class Model
    unrestrict_primary_key
  end
end
