module VCAP::CloudController
  class CopilotSync
    def initialize(config:)
      @config = config
    end

    def sync
      puts 'syncing'

      CopilotAdapter.bulk_sync(
        #please do not do Route.all, we need to only fetch Guid and fqdn,
        #fqdn will require eager loading domains in the sql query
        routes: Route.all,
        route_mappings: [],
        processes: []
      )
      # Look up Routes, RouteMappings, and Processes from Capi DB
      # Send them to Copilot using the CopilotAdapter
    end
  end
end
