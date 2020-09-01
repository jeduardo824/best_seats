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

      finder_result.any? ? return_best_seats : return_error
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
        {
          json: {
            success: "The best seats available are: #{best_seats_labels}",
            best_seats: best_seats_list
          },
          status: :ok
        }
      end

      def best_seats_list
        finder_result.map { |seat| seat.attributes.except("created_at", "updated_at") }
      end

      def best_seats_labels
        finder_result.pluck(:label)
      end

      def return_error
        {
          json: {
            error: "The server can't find the best seats. Check your data and try again",
          },
          status: :not_found
        }
      end
  end
end
