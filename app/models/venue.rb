# frozen_string_literal: true

class Venue < ApplicationRecord
  has_many :available_seats, dependent: :destroy

  validates :title, presence: true
  validates :rows, :columns, numericality: { only_integer: true, greater_than: 0 }
end
