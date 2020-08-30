# frozen_string_literal: true

require "rails_helper"

RSpec.describe BestSeats::NotGroupedFinder, type: :service do
  describe ".call" do
    let(:venue) { create(:venue, rows: 5, columns: 5) }

    context "without enough seats available" do
      let(:expected_message) do
        { error: "Not enough seats available." }
      end

      subject { described_class.call(venue: venue, seats_quantity: 2) }

      before do
        create(:available_seat, venue: venue, label: "A3", row: 1, column: 3)
      end

      it "returns an error message" do
        expect(subject).to eq(expected_message)
      end
    end

    context "venue with odd number of columns" do
      let!(:expected_seat_1) { create(:available_seat, venue: venue, row: 1, column: 3) }
      let!(:expected_seat_2) { create(:available_seat, venue: venue, row: 2, column: 3) }

      before do
        create(:available_seat, venue: venue, label: "C5", row: 3, column: 5)
      end

      subject { described_class.call(venue: venue, seats_quantity: seats_quantity) }

      context "requesting only one seat" do
        let(:seats_quantity) { 1 }

        it "returns the seat on the first row and on the center (A3)" do
          expect(subject).to eq([expected_seat_1])
        end
      end

      context "requesting more than one seat (best seats in different rows)" do
        let(:seats_quantity) { 2 }

        it "returns the centered seats on the first and second row" do
          expect(subject).to eq([expected_seat_1, expected_seat_2])
        end
      end

      context "requesting more than one seat (best seats in same row)" do
        let!(:same_row_seat) do
          create(:available_seat, venue: venue, row: 1, column: 1)
        end
        let(:seats_quantity) { 2 }

        it "returns the centered seat and the other seat on the same row" do
          expect(subject).to eq([expected_seat_1, same_row_seat])
        end
      end
    end

    context "venue with even number of columns" do
      let(:venue) { create(:venue, rows: 5, columns: 4) }
      let!(:expected_seat_1) { create(:available_seat, venue: venue, row: 1, column: 2) }
      let!(:expected_seat_2) { create(:available_seat, venue: venue, row: 2, column: 2) }

      before do
        create(:available_seat, venue: venue, label: "C5", row: 3, column: 5)
      end

      subject { described_class.call(venue: venue, seats_quantity: seats_quantity) }

      context "requesting only one seat" do
        let(:seats_quantity) { 1 }

        it "returns the seat on the first row and on the left-center (A2)" do
          expect(subject).to eq([expected_seat_1])
        end
      end

      context "requesting more than one seat (best seats in different rows)" do
        let(:seats_quantity) { 2 }

        it "returns the left-centered seats on the first and second row" do
          expect(subject).to eq([expected_seat_1, expected_seat_2])
        end
      end

      context "requesting more than one seat (best seats in same row)" do
        let!(:same_row_seat) do
          create(:available_seat, venue: venue, row: 1, column: 1)
        end
        let(:seats_quantity) { 2 }

        before do
          create(:available_seat, venue: venue, row: 1, column: 4)
        end

        it "returns the left-centered seat and the other seat on the same row" do
          expect(subject).to eq([expected_seat_1, same_row_seat])
        end
      end
    end
  end
end
