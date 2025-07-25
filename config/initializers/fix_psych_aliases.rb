# Fix for Psych::AliasesNotEnabled error in Rails asset precompilation
# This occurs when Psych 4.x introduces breaking changes for YAML alias parsing

if defined?(Psych) && Psych::VERSION >= '4.0.0'
  # Enable aliases in YAML loading to fix precompile errors
  module Psych
    class << self
      alias_method :original_safe_load, :safe_load
      
      def safe_load(yaml_content, *args, **kwargs)
        kwargs[:aliases] = true unless kwargs.key?(:aliases)
        original_safe_load(yaml_content, *args, **kwargs)
      end
      
      alias_method :original_load, :load
      
      def load(yaml_content, *args, **kwargs)
        kwargs[:aliases] = true unless kwargs.key?(:aliases)
        original_load(yaml_content, *args, **kwargs)
      end
    end
  end
end