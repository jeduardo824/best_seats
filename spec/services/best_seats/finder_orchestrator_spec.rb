# frozen_string_literal: true

require "rails_helper"

RSpec.describe BestSeats::FinderOrchestrator, type: :service do
  describe ".call" do
    let(:venue) { create(:venue, rows: 5, columns: 5) }

    context "requesting only one seat" do
      let(:seats_quantity) { 1 }

      subject do
        described_class.call(venue: venue,
                             seats_quantity: seats_quantity,
                             group_seats: false)
      end

      context "when there's a seat available" do
        let!(:available_seat) { create(:available_seat, venue: venue) }
        let(:expected_message) do
          {
            json: { success: "The best seats available are: [\"#{available_seat.label}\"]" },
            status: :ok
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end

      context "when there's not a seat available" do
        let(:expected_message) do
          {
            json: { error: "Not enough seats available." },
            status: :not_found
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end
    end

    context "requesting more than one seat without grouping seats" do
      let(:seats_quantity) { 2 }

      subject do
        described_class.call(venue: venue,
                             seats_quantity: seats_quantity,
                             group_seats: false)
      end

      context "when there's a seat available" do
        let!(:available_seat_1) { create(:available_seat, venue: venue, row: 1, column: 1) }
        let!(:available_seat_2) { create(:available_seat, venue: venue, row: 2, column: 2) }
        let(:seats_array) do
          "[\"#{available_seat_1.label}\", \"#{available_seat_2.label}\"]"
        end
        let(:expected_message) do
          {
            json: { success: "The best seats available are: #{seats_array}" },
            status: :ok
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end

      context "when there's not a seat available" do
        let(:expected_message) do
          {
            json: { error: "Not enough seats available." },
            status: :not_found
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end
    end

    context "requesting more than one seat grouping seats" do
      let(:seats_quantity) { 2 }

      subject do
        described_class.call(venue: venue,
                             seats_quantity: seats_quantity,
                             group_seats: true)
      end

      context "when there's a seat available" do
        let!(:available_seat_1) { create(:available_seat, venue: venue, row: 1, column: 1) }
        let!(:available_seat_2) { create(:available_seat, venue: venue, row: 1, column: 2) }
        let(:seats_array) do
          "[\"#{available_seat_1.label}\", \"#{available_seat_2.label}\"]"
        end
        let(:expected_message) do
          {
            json: { success: "The best seats available are: #{seats_array}" },
            status: :ok
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end

      context "when there's not a seat available" do
        let(:expected_message) do
          {
            json: { error: "Not enough grouped seats available." },
            status: :not_found
          }
        end

        it "returns the expected success message" do
          expect(subject).to eq(expected_message)
        end
      end
    end
  end
end
