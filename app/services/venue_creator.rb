# frozen_string_literal: true

class VenueCreator
  def initialize(params)
    @params = params
  end

  def self.call(params:)
    new(params).call
  end

  def call
    venue.valid? ? create_seats : error_response
  end

  private
    attr_reader :params

    def venue
      @_venue ||= Venue.create(title: title, rows: rows, columns: columns)
    end

    def create_seats
      ActiveRecord::Base.transaction do
        AvailableSeatsCreator.call(venue: venue, params: available_seats_params)
      end

      successful_response
    end

    def title
      params.fetch(:title)
    end

    def rows
      params.fetch(:rows)
    end

    def columns
      params.fetch(:columns)
    end

    def available_seats_params
      params.fetch(:available_seats)
    end

    def successful_response
      {
        json: { message: "Venue created successfully.", venue_id: venue.id },
        status: :created
      }
    end

    def error_response
      {
        json: {
          message: "Error! Check your data and try again.",
          errors: venue.errors.messages
        },
        status: :unprocessable_entity
      }
    end
end
