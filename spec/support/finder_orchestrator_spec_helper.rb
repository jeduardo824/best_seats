# frozen_string_literal: true

module FinderOrchestratorSpecHelper
  include AttributesCleaner

  def success_response(seats)
    {
      json: {
        success: "The best seats available are: #{seats.pluck(:label)}",
        best_seats: seats.map { |seat| clean_unused_attributes(seat) }
      },
      status: :ok
    }
  end

  def failure_response
    {
      json: { error: "The server can't find the best seats. Check your data and try again" },
      status: :not_found
    }
  end
end
