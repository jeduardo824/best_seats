# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BestSeatsController, type: :routing do
  describe "routing" do
    let(:random_id) { 1 }
    let(:path) { "/api/v1/venues/#{random_id}/best_seats" }

    it "routes to #create" do
      expect(get: path).to route_to("api/v1/best_seats#find", venue_id: random_id.to_s)
    end
  end
end
