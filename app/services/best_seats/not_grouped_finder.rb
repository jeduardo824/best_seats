# frozen_string_literal: true

module BestSeats
  class NotGroupedFinder
    def initialize(venue, seats_quantity)
      @venue = venue
      @seats_quantity = seats_quantity
    end

    def self.call(venue:, seats_quantity:)
      new(venue, seats_quantity).call
    end

    def call
      return not_enough_seats unless enough_seats_available?
      sort_seats
      get_best_seats
    end

    private
      attr_reader :venue, :seats_quantity

      delegate :ordered_seats, to: :venue, prefix: true

      def enough_seats_available?
        venue_ordered_seats.count >= seats_quantity
      end

      def not_enough_seats
        []
      end

      def available_seats
        @_available_seats ||= venue_ordered_seats.group_by(&:row)
      end

      def sort_seats
        available_seats.each_value do |seats_array|
          seats_array.sort_by!(&:abs_distance_to_center)
        end
      end

      def get_best_seats
        best_seats.take(seats_quantity)
      end

      def best_seats
        available_seats.values.flatten
      end
  end
end
