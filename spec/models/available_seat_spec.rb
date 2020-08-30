# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableSeat, type: :model do
  describe "belongs_to" do
    it { should belong_to(:venue) }
  end

  describe "validations" do
    it { should validate_presence_of(:label) }

    it do
      should validate_numericality_of(:row).only_integer
                                           .is_greater_than(0)
    end

    it do
      should validate_numericality_of(:column).only_integer
                                               .is_greater_than(0)
    end
  end

  describe "#distance_to_center" do
    context "when venue has odd number of columns" do
      context "and seat is before the center seat" do
        let(:venue) { create(:venue, rows: 1, columns: 5) }

        subject { create(:available_seat, venue: venue, column: 2) }

        it "returns the distance of the seat to the center (positive)" do
          expect(subject.distance_to_center).to eq(1)
        end
      end

      context "and seat is before the center seat" do
        let(:venue) { create(:venue, rows: 1, columns: 5) }

        subject { create(:available_seat, venue: venue, column: 4) }

        it "returns the distance of the seat to the center (negative)" do
          expect(subject.distance_to_center).to eq(-1)
        end
      end
    end

    context "when venue has even number of columns" do
      context "and seat is left-centered seat" do
        let(:venue) { create(:venue, rows: 1, columns: 4) }

        subject { create(:available_seat, venue: venue, column: 2) }

        it "is considered the center (returns 0)" do
          expect(subject.distance_to_center).to eq(0)
        end
      end

      context "and seat is right-centered seat" do
        let(:venue) { create(:venue, rows: 1, columns: 4) }

        subject { create(:available_seat, venue: venue, column: 3) }

        it "is considered after the center" do
          expect(subject.distance_to_center).to eq(-1)
        end
      end
    end
  end

  describe "#abs_distance_to_center" do
    context "when venue has odd number of columns" do
      context "and seat is before the center seat" do
        let(:venue) { create(:venue, rows: 1, columns: 5) }

        subject { create(:available_seat, venue: venue, column: 2) }

        it "returns the absolute distance of the seat to the center" do
          expect(subject.abs_distance_to_center).to eq(1)
        end
      end

      context "and seat is before the center seat" do
        let(:venue) { create(:venue, rows: 1, columns: 5) }

        subject { create(:available_seat, venue: venue, column: 4) }

        it "returns the absolute distance of the seat to the center" do
          expect(subject.abs_distance_to_center).to eq(1)
        end
      end
    end

    context "when venue has even number of columns" do
      context "and seat is left-centered seat" do
        let(:venue) { create(:venue, rows: 1, columns: 4) }

        subject { create(:available_seat, venue: venue, column: 2) }

        it "is considered the center (returns 0)" do
          expect(subject.abs_distance_to_center).to eq(0)
        end
      end

      context "and seat is right-centered seat" do
        let(:venue) { create(:venue, rows: 1, columns: 4) }

        subject { create(:available_seat, venue: venue, column: 3) }

        it "returns the absolut distance of the seat to the center" do
          expect(subject.abs_distance_to_center).to eq(1)
        end
      end
    end
  end
end
