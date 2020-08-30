# frozen_string_literal: true

class AvailableSeatsCreator
  INITIAL_LETTER = "A"

  def initialize(venue, params)
    @venue = venue
    @params = params
  end

  def self.call(venue:, params:)
    new(venue, params).call
  end

  def call
    letter = INITIAL_LETTER

    1.upto(venue_rows) do |row|
      create_columns(letter, row)
      letter = letter.next
    end
  end

  private
    attr_reader :venue, :params

    delegate :rows, :columns, to: :venue, prefix: true

    def create_columns(letter, row)
      1.upto(venue_columns) do |column|
        label = "#{letter}#{column}"
        next unless is_available?(label)
        create_seat(label, row, column)
      end
    end

    def create_seat(label, row, column)
      AvailableSeat.create!(
        label: label,
        row: row,
        column: column,
        venue: venue
      )
    end

    def is_available?(label)
      available_seats.include?(label)
    end

    def available_seats
      @_available_seats ||= params.map do |seat|
        "#{seat[:row].capitalize}#{seat[:column]}".gsub(/\s+/, "")
      end
    end
end
