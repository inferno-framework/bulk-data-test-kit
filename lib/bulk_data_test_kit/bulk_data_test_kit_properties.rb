module BulkDataTestKit
  class BulkDataTestKitProperties
    ATTRIBUTES = [
      :resource_type,
      :bulk_export_url
    ].freeze

    ATTRIBUTES.each { |name| attr_reader name }

    def initialize(**properties)
      properties.each do |key, value|
        raise StandardError, "Unknown search test property: #{key}" unless ATTRIBUTES.include?(key)

        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
