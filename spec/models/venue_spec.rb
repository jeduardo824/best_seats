# frozen_string_literal: true

require "rails_helper"

RSpec.describe Venue, type: :model do
  describe "has_many" do
    it { should have_many(:available_seats) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }

    it do
      should validate_numericality_of(:rows).only_integer
                                            .is_greater_than(0)
    end

    it do
      should validate_numericality_of(:columns).only_integer
                                               .is_greater_than(0)
    end
  end

  describe "#center_seat" do
    context "when number of columns is even" do
      subject { create(:venue, columns: 4) }

      it "returns half numbers of columns" do
        expect(subject.center_seat).to eq(2)
      end
    end

    context "when number of columns is not even" do
      subject { create(:venue, columns: 5) }

      it "returns the ceil value of the half number of columns" do
        expect(subject.center_seat).to eq(3)
      end
    end
  end

  describe "#ordered_seats" do
    context "when number of columns is even" do
      let!(:first_seat) { create(:available_seat, venue: subject, row: 1, column: 3) }
      let!(:second_seat) { create(:available_seat, venue: subject, row: 1, column: 4) }
      let(:expected_seats_order) { [second_seat, first_seat] }

      subject { create(:venue, rows: 1, columns: 4) }

      it "returns half numbers of columns" do
        expect(subject.ordered_seats).to eq(expected_seats_order)
      end
    end

    context "when number of columns is odd" do
      let!(:first_seat) { create(:available_seat, venue: subject, row: 1, column: 3) }
      let!(:second_seat) { create(:available_seat, venue: subject, row: 1, column: 4) }
      let(:expected_seats_order) { [first_seat, second_seat] }

      subject { create(:venue, rows: 1, columns: 5) }

      it "returns half numbers of columns" do
        expect(subject.ordered_seats).to eq(expected_seats_order)
      end
    end
  end
end
