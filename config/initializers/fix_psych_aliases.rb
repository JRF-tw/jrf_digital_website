# Fix Psych YAML alias issues for Rails 5.2 + Ruby 2.7.8 + Psych 5.2+
# This addresses compatibility issues with newer Psych versions that don't enable aliases by default

module Rails
  class Application
    class Configuration
      def database_configuration
        path = paths["config/database"].existent.first
        yaml = Pathname.new(path) if path

        config = if yaml && yaml.exist?
          require "yaml"
          require "erb"
          
          # Read and process ERB
          erb_result = ERB.new(yaml.read).result
          
          # Parse YAML with aliases enabled for newer Psych versions
          loaded_yaml = begin
            if defined?(Psych) && Psych::VERSION >= '4.0'
              YAML.load(erb_result, aliases: true) || {}
            else
              YAML.load(erb_result) || {}
            end
          rescue Psych::AliasesNotEnabled
            # Fallback for when aliases parameter is not supported
            YAML.load(erb_result, aliases: true) || {}
          end
          
          # Handle shared configuration merging if present
          shared = loaded_yaml.delete("shared")
          if shared
            loaded_yaml.each do |_k, values|
              values.reverse_merge!(shared) if values.is_a?(Hash)
            end
          end
          loaded_yaml
        elsif ENV['DATABASE_URL']
          # Value from ENV['DATABASE_URL'] is set to default database connection
          # by Active Record.
          {}
        else
          raise "Could not load database configuration. No such file - #{paths["config/database"].instance_variable_get(:@paths)}"
        end

        config
      rescue Psych::SyntaxError => e
        raise "YAML syntax error occurred while parsing #{path}. " \
              "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. " \
              "Error: #{e.message}"
      rescue => e
        raise e, "Cannot load database configuration:\n#{e.message}", e.backtrace
      end
    end
  end
end