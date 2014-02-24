require 'orm_adapter'
require 'active_support'

module OrmAdapter
  class Couchbase < ::OrmAdapter::Base
    def column_names
      klass.properties
    end

    def get!(id)
      klass.find(wrap_key(id))
    end

    def get(id)
      klass.find_by_id(wrap_key(id))
    end

    def find_first(options = {})
      conditions, order, limit, offset = extract_conditions!(options)
      if conditions.empty?
        klass.all.first
      elsif conditions.keys.first == :id
        klass.find_by_id(conditions.values.first)
      else
        view = klass.send("by_#{conditions.keys.first}")
        view.first(key: conditions.values.first)
      end
    end

    def find_all(options = {})
      conditions, order, limit, offset = extract_conditions!(options)
      if conditions.empty?
        klass.all(limit: limit, skip: offset)
      elsif conditions.keys.first == :id
        klass.find_by_id(conditions.values.first)
      else
        view = klass.send("by_#{conditions.keys.first}")
        view.fetch(key: conditions.values.first, limit: limit, skip: offet)
      end
    end

    def create!(attributes = {})
      klass.create!(attributes)
    end

    def destroy(object)
      object.destroy if valid_object?(object)
    end
  end
end

ActiveSupport.on_load :couchbase_model do
  extend ::OrmAdapter::ToAdapter
  self::OrmAdapter = ::OrmAdapter::Couchbase
end
