require 'cf-copilot'

module VCAP::CloudController
  class CopilotAdapter
    class CopilotUnavailable < StandardError
    end

    class << self
      def create_route(route)
        copilot_client.upsert_route(
          guid: route.guid,
          host: route.fqdn
        )
      rescue StandardError => e
        raise CopilotUnavailable.new(e.message)
      end

      def map_route(route_mapping)
        copilot_client.map_route(
          capi_process_guid: route_mapping.process.guid,
          route_guid: route_mapping.route.guid
        )
      rescue StandardError => e
        raise CopilotUnavailable.new(e.message)
      end

      def unmap_route(route_mapping)
        copilot_client.unmap_route(
          capi_process_guid: route_mapping.process.guid,
          route_guid: route_mapping.route.guid
        )
      rescue StandardError => e
        raise CopilotUnavailable.new(e.message)
      end

      def upsert_capi_diego_process_association(process)
        copilot_client.upsert_capi_diego_process_association(
          capi_process_guid: process.guid,
          diego_process_guids: [Diego::ProcessGuid.from_process(process)]
        )
      rescue StandardError => e
        raise CopilotUnavailable.new(e.message)
      end

      def delete_capi_diego_process_association(process)
        copilot_client.delete_capi_diego_process_association(capi_process_guid: process.guid)
      rescue StandardError => e
        raise CopilotUnavailable.new(e.message)
      end

      def bulk_sync(routes:, route_mappings:, processes:)
        # send bulk sync data to pilot, given all the capi models
      end

      private

      def copilot_client
        CloudController::DependencyLocator.instance.copilot_client
      end
    end
  end
end
