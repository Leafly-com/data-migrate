module DataMigrate
  class DataSchemaMigration
    class << self
      delegate :table_name, :primary_key, :create_table, :normalized_versions, :create, :create!, :table_exists?, :exists?, :where, to: :instance

      def instance
        @instance ||= Class.new(::ActiveRecord::SchemaMigration) do
          define_singleton_method(:table_name) { ActiveRecord::Base.table_name_prefix + DataMigrate.config.data_migrations_table_name + ActiveRecord::Base.table_name_suffix }
          define_singleton_method(:primary_key) { "version" }
        end
      end
    end
  end
end
