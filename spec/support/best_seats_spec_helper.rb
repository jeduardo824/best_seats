# frozen_string_literal: true

module BestSeatsSpecHelper
  include AttributesCleaner

  def success_response(seats)
    {
      success: "The best seats available are: #{seats.pluck(:label)}",
      best_seats: seats.map { |seat| clean_unused_attributes(seat) }
    }
  end

  def failure_response
    {
      error: "The server can't find the best seats. Check your data and try again"
    }
  end
end
