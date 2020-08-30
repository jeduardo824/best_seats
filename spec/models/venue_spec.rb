# frozen_string_literal: true

require "rails_helper"

RSpec.describe Venue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "has_many" do
    it { should have_many(:available_seats) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }

    it do
      should validate_numericality_of(:rows).only_integer
                                            .is_greater_than(0)
    end

    it do
      should validate_numericality_of(:columns).only_integer
                                               .is_greater_than(0)
    end
  end
end
