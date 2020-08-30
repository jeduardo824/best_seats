# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/venues/:venue_id/best_seats", type: :request do
  describe "GET /find" do
    context "with valid parameters" do
      let(:venue) { create(:venue, rows: 5, columns: 5) }

      subject do
        get api_v1_venue_best_seats_url(venue.id),
        params: {
          seats_quantity: seats_quantity,
          group_seats: group_seats
        }
      end

      context "requesting one seat" do
        context "when venue has seat available" do
          let!(:available_seat) { create(:available_seat, venue: venue, row: 1, column: 3) }
          let(:seats_quantity) { 1 }
          let(:group_seats) { false }
          let(:expected_response) do
            {
              success: "The best seats available are: [\"#{available_seat.label}\"]"
            }
          end

          before do
            create(:available_seat, venue: venue, row: 1, column: 1)
            subject
          end

          it "returns the correct http status" do
            expect(response).to have_http_status(:ok)
          end

          it "returns the correct message" do
            expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
          end
        end

        context "when venue has not seat available" do
          let(:seats_quantity) { 1 }
          let(:group_seats) { false }
          let(:expected_response) do
            {
              error: "Not enough seats available."
            }
          end

          before do
            subject
          end

          it "returns the correct http status" do
            expect(response).to have_http_status(:not_found)
          end

          it "returns the correct message" do
            expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
          end
        end
      end

      context "requesting more than one seat" do
        context "without grouping seats" do
          context "when venue has seats available" do
            let!(:available_seat_1) { create(:available_seat, venue: venue, row: 1, column: 3) }
            let!(:available_seat_2) { create(:available_seat, venue: venue, row: 3, column: 1) }
            let(:seats_quantity) { 2 }
            let(:group_seats) { false }
            let(:seats_array) do
              "[\"#{available_seat_1.label}\", \"#{available_seat_2.label}\"]"
            end
            let(:expected_response) do
              {
                success: "The best seats available are: #{seats_array}"
              }
            end

            before do
              create(:available_seat, venue: venue, row: 5, column: 1)
              subject
            end

            it "returns the correct http status" do
              expect(response).to have_http_status(:ok)
            end

            it "returns the correct message" do
              expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
            end
          end

          context "when venue has not seats available" do
            let(:seats_quantity) { 2 }
            let(:group_seats) { false }
            let(:expected_response) do
              {
                error: "Not enough seats available."
              }
            end

            before do
              create(:available_seat, venue: venue, row: 5, column: 1)
              subject
            end

            it "returns the correct http status" do
              expect(response).to have_http_status(:not_found)
            end

            it "returns the correct message" do
              expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
            end
          end
        end

        context "grouping seats" do
          context "when venue has grouped seats available" do
            let!(:available_seat_1) { create(:available_seat, venue: venue, row: 1, column: 2) }
            let!(:available_seat_2) { create(:available_seat, venue: venue, row: 1, column: 3) }
            let(:seats_quantity) { 2 }
            let(:group_seats) { true }
            let(:seats_array) do
              "[\"#{available_seat_1.label}\", \"#{available_seat_2.label}\"]"
            end
            let(:expected_response) do
              {
                success: "The best seats available are: #{seats_array}"
              }
            end

            before do
              create(:available_seat, venue: venue, row: 5, column: 1)
              subject
            end

            it "returns the correct http status" do
              expect(response).to have_http_status(:ok)
            end

            it "returns the correct message" do
              expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
            end
          end

          context "when venue has not seats available" do
            let(:seats_quantity) { 2 }
            let(:group_seats) { true }
            let(:expected_response) do
              {
                error: "Not enough grouped seats available."
              }
            end

            before do
              create(:available_seat, venue: venue, row: 5, column: 1)
              subject
            end

            it "returns the correct http status" do
              expect(response).to have_http_status(:not_found)
            end

            it "returns the correct message" do
              expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
            end
          end

          context "when venue has seats available but they are not grouped" do
            let(:seats_quantity) { 2 }
            let(:group_seats) { true }
            let(:expected_response) do
              {
                error: "Not enough grouped seats available."
              }
            end

            before do
              create(:available_seat, venue: venue, row: 1, column: 3)
              create(:available_seat, venue: venue, row: 1, column: 1)
              create(:available_seat, venue: venue, row: 5, column: 4)
              subject
            end

            it "returns the correct http status" do
              expect(response).to have_http_status(:not_found)
            end

            it "returns the correct message" do
              expect(JSON.parse(response.body)).to eq(expected_response.stringify_keys)
            end
          end
        end
      end
    end
  end
end
