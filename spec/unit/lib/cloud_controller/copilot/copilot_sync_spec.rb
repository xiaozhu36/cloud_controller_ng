require 'spec_helper'
require 'cloud_controller/copilot/copilot_adapter'
require 'cloud_controller/copilot/copilot_sync'

module VCAP::CloudController
  RSpec.describe CopilotSync do
    before do
      allow(CopilotAdapter).to receive(:bulk_sync)
    end


    describe '#sync' do
      let!(:route) { Route.make }

      it 'syncs' do
        CopilotSync.new(config: "??").sync
        expect(CopilotAdapter).to have_received(:bulk_sync).with(
          routes: [route],
          route_mappings: [],
          processes: []
        )
      end
    end
  end
end
