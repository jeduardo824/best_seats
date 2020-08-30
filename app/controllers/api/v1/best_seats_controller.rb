# frozen_string_literal: true

class Api::V1::BestSeatsController < ApplicationController
  def find
    render BestSeats::FinderOrchestrator.call(venue: venue,
                                              seats_quantity: seats_quantity,
                                              group_seats: group_seats?)
  end

  private
    def best_seats_params
      params.permit(:venue_id, :seats_quantity, :group_seats)
    end

    def venue
      Venue.find(best_seats_params[:venue_id])
    end

    def seats_quantity
      best_seats_params[:seats_quantity].to_i
    end

    def group_seats?
      best_seats_params[:group_seats] == "true"
    end
end
