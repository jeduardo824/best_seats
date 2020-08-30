# frozen_string_literal: true

module BestSeats
  class GroupedFinder
    def initialize(venue, seats_quantity)
      @venue = venue
      @seats_quantity = seats_quantity
    end

    def self.call(venue:, seats_quantity:)
      new(venue, seats_quantity).call
    end

    def call
      @available_seats = venue_available_seats.order(:row, :column)
                                              .group_by(&:row)

      clean_rows_without_enough_seats
      return not_enough_grouped_seats if available_seats.empty?
      get_best_grouped_seats
    end

    private
      attr_reader :available_seats, :venue, :seats_quantity

      delegate :available_seats, to: :venue, prefix: true

      def not_enough_grouped_seats
        { error: "Not enough grouped seats available." }
      end

      def clean_rows_without_enough_seats
        available_seats.select! do |row, seats_array|
          seats_array.length >= seats_quantity
        end
      end

      def get_best_grouped_seats
        available_seats.each_value do |seats_array|
          best_seats = find_row_best_seats(seats_array)
          return best_seats if best_seats
        end

        not_enough_grouped_seats
      end

      def find_row_best_seats(seats_array)
        if seats_options = get_seats_possibilities(seats_array)
          seats_options.sort_by! { |option| option.first }
          seats_options.dig(0, 1)
        end
      end

      def get_seats_possibilities(seats_array)
        seats_array.each_cons(seats_quantity).map do |seats_chunk|
          next if seats_not_consecutive?(seats_chunk.first,
                                         seats_chunk.last,
                                         seats_chunk.length)

          [seats_chunk.sum(&:abs_distance_to_center), seats_chunk]
        end.compact
      end

      def seats_not_consecutive?(first_seat, last_seat, chunk_length)
        last_seat.column - first_seat.column + 1 != chunk_length
      end
  end
end
