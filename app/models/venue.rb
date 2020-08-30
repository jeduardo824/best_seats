# frozen_string_literal: true

class Venue < ApplicationRecord
  has_many :available_seats, dependent: :destroy

  validates :title, presence: true
  validates :rows, :columns, numericality: { only_integer: true, greater_than: 0 }

  def center_seat
    center = columns / 2.0
    columns.even? ? center : center.ceil
  end

  def ordered_seats
    if columns.even?
      available_seats.order(:row, column: :desc)
    else
      available_seats.order(:row, :column)
    end
  end
end
