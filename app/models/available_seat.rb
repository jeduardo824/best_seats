# frozen_string_literal: true

class AvailableSeat < ApplicationRecord
  belongs_to :venue

  validates :label, presence: true
  validates :row, :column, numericality: { only_integer: true, greater_than: 0 }

  def distance_to_center
    venue.center_seat - column
  end

  def abs_distance_to_center
    distance_to_center.abs
  end
end
