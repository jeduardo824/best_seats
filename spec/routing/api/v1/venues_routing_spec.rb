# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::VenuesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/venues").to route_to("api/v1/venues#index")
    end

    it "routes to #new" do
      expect(get: "/api/v1/venues/new").to route_to("api/v1/venues#new")
    end

    it "routes to #show" do
      expect(get: "/api/v1/venues/1").to route_to("api/v1/venues#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/api/v1/venues/1/edit").to route_to("api/v1/venues#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/venues").to route_to("api/v1/venues#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/venues/1").to route_to("api/v1/venues#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/venues/1").to route_to("api/v1/venues#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/venues/1").to route_to("api/v1/venues#destroy", id: "1")
    end
  end
end
