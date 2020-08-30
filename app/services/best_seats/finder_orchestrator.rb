# frozen_string_literal: true

module BestSeats
  class FinderOrchestrator
    def initialize(venue:, seats_quantity:, group_seats:)
      @venue = venue
      @seats_quantity = seats_quantity
      @group_seats = group_seats
    end

    def self.call(venue:, seats_quantity:, group_seats:)
      new(venue: venue,
          seats_quantity: seats_quantity,
          group_seats: group_seats).call
    end

    def call
      @finder_result = call_finder_service

      if finder_result.kind_of?(Array)
        { json: return_best_seats, status: :ok }
      else
        { json: finder_result, status: :not_found }
      end
    end

    private

      attr_reader :finder_result, :venue, :seats_quantity, :group_seats

      delegate :available_seats, to: :venue, prefix: true

      def call_finder_service
        requesting_grouped_seats? ? find_grouped_seats : find_not_grouped_seats
      end

      def requesting_grouped_seats?
        group_seats && seats_quantity > 1
      end

      def find_grouped_seats
        BestSeats::GroupedFinder.call(venue: venue, seats_quantity: seats_quantity)
      end

      def find_not_grouped_seats
        BestSeats::NotGroupedFinder.call(venue: venue, seats_quantity: seats_quantity)
      end

      def return_best_seats
        { success: "The best seats available are: #{best_seats_labels}" }
      end

      def best_seats_labels
        finder_result.pluck(:label)
      end
  end
end
