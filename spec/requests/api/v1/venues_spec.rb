# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/venues", type: :request do
  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          title: "My Venue",
          rows: 10,
          columns: 10,
          available_seats: [
            {
              row: "a",
              column:  2
            },
            {
              row: "b",
              column: 4
            }
          ]
        }
      end
      let(:expected_response) do
        { message: "Venue created successfully.", venue_id: Venue.first.id }
      end

      subject { post api_v1_venues_url, params: { venue: valid_attributes } }

      it "returns the correct http status" do
        subject
        expect(response).to have_http_status(:created)
      end

      it "creates a new Venue" do
        expect { subject }.to change(Venue, :count).by(1)
      end

      it "creates new AvailabeSeats" do
        expect { subject }.to change(AvailableSeat, :count).by(2)
      end

      it "returns the correct message" do
        subject
        expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          title: "My Venue",
          rows: -10,
          columns: 10,
          available_seats: [
            {
              row: "a",
              column:  2
            },
            {
              row: "b",
              column: 4
            }
          ]
        }
      end
      let(:error_message) do
        {
         message: "Error! Check your data and try again.",
         errors: { rows: ["must be greater than 0"] }
        }
      end

      subject { post api_v1_venues_url, params: { venue: invalid_attributes } }

      before do
        subject
      end

      it "returns the correct http status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct http status" do
        expect(JSON.parse(response.body)).to eq(error_message.deep_stringify_keys)
      end
    end
  end
end
