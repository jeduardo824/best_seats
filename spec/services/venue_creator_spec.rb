# frozen_string_literal: true

require "rails_helper"

RSpec.describe VenueCreator, type: :service do
  describe ".call" do
    subject { described_class.call(params: params) }

    context "with valid available seats" do
      let(:params) do
        {
          title: "My Title",
          rows: 10,
          columns: 10,
          available_seats: [
            {
              row: "a",
              column: 1
            },
            {
              row: "b",
              column: 5
            },
            {
              row: "h",
              column: 7
            }
          ]
        }
      end
      let(:expected_message) do
        {
          json: { message: "Venue created successfully.", venue_id: Venue.first.id },
          status: :created
        }
      end

      it "creates the Venue correctly" do
        expect { subject }.to change(Venue, :count).from(0).to(1)
      end

      it "creates the available Seats correctly" do
        expect { subject }.to change(AvailableSeat, :count).from(0).to(3)
      end

      it "returns a successful message" do
        expect(subject).to eq(expected_message)
      end
    end

    context "with invalid available seats" do
      let(:params) do
        {
          title: "My Title",
          rows: 10,
          columns: 10,
          available_seats: [
            {
              row: "qwerty",
              column: 7
            }
          ]
        }
      end
      let(:expected_message) do
        {
          json: { message: "Venue created successfully.", venue_id: Venue.first.id },
          status: :created
        }
      end

      it "creates the Venue correctly" do
        expect { subject }.to change(Venue, :count).from(0).to(1)
      end

      it "does not create available Seats" do
        expect(AvailableSeat.count).to eq(0)
      end

      it "returns a successful message" do
        expect(subject).to eq(expected_message)
      end
    end

    context "with invalid params" do
      context "with invalid rows" do
        let(:params) do
          {
            title: "My Title",
            rows: "a",
            columns: 10,
            available_seats: [
              {
                row: "a",
                column: 1
              }
            ]
          }
        end
        let(:error_message) do
          {
           message: "Error! Check your data and try again.",
           errors: { rows: ["is not a number"] }
          }
        end

        before do
          subject
        end

        it "does not create a Venue" do
          expect(Venue.count).to eq(0)
        end

        it "does not create Available Seats" do
          expect(AvailableSeat.count).to eq(0)
        end

        it "returns an error message" do
          expect(subject).to include(json: error_message) & \
                             include(status: :unprocessable_entity)
        end
      end

      context "with rows equals to zero" do
        let(:params) do
          {
            title: "My Title",
            rows: 0,
            columns: 10,
            available_seats: [
              {
                row: "a",
                column: 1
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

        before do
          subject
        end

        it "does not create a Venue" do
          expect(Venue.count).to eq(0)
        end

        it "does not create Available Seats" do
          expect(AvailableSeat.count).to eq(0)
        end

        it "returns an error message" do
          expect(subject).to include(json: error_message) & \
                             include(status: :unprocessable_entity)
        end
      end

      context "with invalid columns" do
        let(:params) do
          {
            title: "My Title",
            rows: 10,
            columns: "a",
            available_seats: [
              {
                row: "a",
                column: 1
              }
            ]
          }
        end
        let(:error_message) do
          {
           message: "Error! Check your data and try again.",
           errors: { columns: ["is not a number"] }
          }
        end

        before do
          subject
        end

        it "does not create a Venue" do
          expect(Venue.count).to eq(0)
        end

        it "does not create Available Seats" do
          expect(AvailableSeat.count).to eq(0)
        end

        it "returns an error message" do
          expect(subject).to include(json: error_message) & \
                             include(status: :unprocessable_entity)
        end
      end

      context "with columns equals to zero" do
        let(:params) do
          {
            title: "My Title",
            rows: 10,
            columns: 0,
            available_seats: [
              {
                row: "a",
                column: 1
              }
            ]
          }
        end
        let(:error_message) do
          {
           message: "Error! Check your data and try again.",
           errors: { columns: ["must be greater than 0"] }
          }
        end

        before do
          subject
        end

        it "does not create a Venue" do
          expect(Venue.count).to eq(0)
        end

        it "does not create Available Seats" do
          expect(AvailableSeat.count).to eq(0)
        end

        it "returns an error message" do
          expect(subject).to include(json: error_message) & \
                             include(status: :unprocessable_entity)
        end
      end

      context "without venue title" do
        let(:params) do
          {
            title: "",
            rows: 10,
            columns: 10,
            available_seats: [
              {
                row: "a",
                column: 1
              }
            ]
          }
        end
        let(:error_message) do
          {
           message: "Error! Check your data and try again.",
           errors: { title: ["can't be blank"] }
          }
        end

        before do
          subject
        end

        it "does not create a Venue" do
          expect(Venue.count).to eq(0)
        end

        it "does not create Available Seats" do
          expect(AvailableSeat.count).to eq(0)
        end

        it "returns an error message" do
          expect(subject).to include(json: error_message) & \
                             include(status: :unprocessable_entity)
        end
      end
    end
  end
end
