# frozen_string_literal: true

class Api::V1::VenuesController < ApplicationController
  def create
    render VenueCreator.call(params: venue_params)
  end

  private
    def venue_params
      params.require(:venue)
            .permit(:title, :rows, :columns, available_seats: [ :row, :column ])
    end
end
