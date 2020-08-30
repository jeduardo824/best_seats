# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableSeatsCreator, type: :service do
  describe ".call" do
    let(:venue) { create(:venue, rows: 10, columns: 10) }
    subject { described_class.call(venue:  venue, params: params) }

    context "with valid available seats" do
      let(:params) do
        [
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
      end

      it "creates the available Seats correctly" do
        expect { subject }.to change(AvailableSeat, :count).from(0).to(3)
      end
    end

    context "with invalid row" do
      let(:params) do
        [
          {
            row: "qwerty",
            column: 1
          }
        ]
      end

      it "does not create available Seats" do
        expect(AvailableSeat.count).to eq(0)
      end
    end

    context "with invalid column" do
      let(:params) do
        [
          {
            row: "a",
            column: "qwerty"
          }
        ]
      end

      it "does not create available Seats" do
        expect(AvailableSeat.count).to eq(0)
      end
    end
  end
end
