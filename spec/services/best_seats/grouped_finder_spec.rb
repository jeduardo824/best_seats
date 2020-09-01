# frozen_string_literal: true

require "rails_helper"

RSpec.describe BestSeats::GroupedFinder, type: :service do
  describe ".call" do
    let(:venue) { create(:venue, rows: 5, columns: 5) }

    context "without enough grouped seats available" do
      subject { described_class.call(venue: venue, seats_quantity: 2) }

      before do
        create(:available_seat, venue: venue, label: "A3", row: 1, column: 3)
        create(:available_seat, venue: venue, label: "A5", row: 1, column: 5)
      end

      it "returns an error message" do
        expect(subject).to eq([])
      end
    end

    context "venue with odd number of columns" do
      let!(:expected_seat_2) { create(:available_seat, venue: venue, row: 1, column: 2) }
      let!(:expected_seat_3) { create(:available_seat, venue: venue, row: 1, column: 3) }
      let!(:expected_seat_4) { create(:available_seat, venue: venue, row: 1, column: 4) }

      before do
        # Creating seats in another row to ensure they will not be returned
        create(:available_seat, venue: venue, row: 2, column: 2)
        create(:available_seat, venue: venue, row: 2, column: 3)
        create(:available_seat, venue: venue, row: 2, column: 4)
      end

      subject { described_class.call(venue: venue, seats_quantity: seats_quantity) }

      context "requesting 2 seats" do
        let(:seats_quantity) { 2 }

        it "prioritizes the seat to the left of the center" do
          expect(subject).to eq([expected_seat_2, expected_seat_3])
        end
      end

      context "requesting 3 seats" do
        let(:seats_quantity) { 3 }

        it "returns the centered seats" do
          expect(subject).to eq([expected_seat_2, expected_seat_3, expected_seat_4])
        end
      end

      context "requesting 2 seats with center occupied" do
        let!(:expected_seat_1) { create(:available_seat, venue: venue, row: 1, column: 1) }
        let(:seats_quantity) { 2 }

        before do
          create(:available_seat, venue: venue, row: 1, column: 5)
          expected_seat_3.destroy!
        end

        it "prioritizes the seat to the left of the center" do
          expect(subject).to eq([expected_seat_1, expected_seat_2])
        end
      end

      context "requesting 2 seats with center and left occupied" do
        let!(:expected_seat_5) { create(:available_seat, venue: venue, row: 1, column: 5) }
        let(:seats_quantity) { 2 }

        before do
          expected_seat_3.destroy!
        end

        it "prioritizes the seat to the left of the center" do
          expect(subject).to eq([expected_seat_4, expected_seat_5])
        end
      end
    end

    context "venue with even number of columns" do
      let(:venue) { create(:venue, rows: 5, columns: 8) }
      let!(:expected_seat_2) { create(:available_seat, venue: venue, row: 1, column: 2) }
      let!(:expected_seat_3) { create(:available_seat, venue: venue, row: 1, column: 3) }
      let!(:expected_seat_4) { create(:available_seat, venue: venue, row: 1, column: 4) }
      let!(:expected_seat_5) { create(:available_seat, venue: venue, row: 1, column: 5) }

      before do
        # Creating seats in another row to ensure they will not be returned
        create(:available_seat, venue: venue, row: 2, column: 2)
        create(:available_seat, venue: venue, row: 2, column: 3)
        create(:available_seat, venue: venue, row: 2, column: 4)
      end

      subject { described_class.call(venue: venue, seats_quantity: seats_quantity) }

      context "requesting 3 seats" do
        let(:seats_quantity) { 3 }

        it "prioritizes the centered seats" do
          expect(subject).to eq([expected_seat_3, expected_seat_4, expected_seat_5])
        end
      end

      context "requesting 4 seats" do
        let(:seats_quantity) { 4 }

        before do
          create(:available_seat, venue: venue, row: 1, column: 6)
        end

        it "prioritizes the left-centered seats" do
          expect(subject).to eq([expected_seat_2, expected_seat_3, expected_seat_4, expected_seat_5])
        end
      end
    end

    context "venue with first row occupied" do
      let(:venue) { create(:venue, rows: 5, columns: 8) }
      let!(:expected_seat_3) { create(:available_seat, venue: venue, row: 2, column: 3) }
      let!(:expected_seat_4) { create(:available_seat, venue: venue, row: 2, column: 4) }
      let!(:expected_seat_5) { create(:available_seat, venue: venue, row: 2, column: 5) }

      subject { described_class.call(venue: venue, seats_quantity: seats_quantity) }

      context "requesting 3 seats" do
        let(:seats_quantity) { 3 }

        before do
          # Creating seats in another row to ensure they will not be returned
          create(:available_seat, venue: venue, row: 1, column: 2)
          create(:available_seat, venue: venue, row: 1, column: 3)
        end

        it "returns the seats on the free row" do
          expect(subject).to eq([expected_seat_3, expected_seat_4, expected_seat_5])
        end
      end

      context "requesting 2 seats" do
        let!(:seat_first_row_1) { create(:available_seat, venue: venue, row: 1, column: 1) }
        let!(:seat_first_row_2) { create(:available_seat, venue: venue, row: 1, column: 2) }
        let(:seats_quantity) { 2 }

        it "returns the free seats on the first row" do
          expect(subject).to eq([seat_first_row_1, seat_first_row_2])
        end
      end
    end
  end
end
