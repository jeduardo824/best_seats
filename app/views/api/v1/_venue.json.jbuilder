# frozen_string_literal: true

json.extract! venue, :id, :title, :rows, :columns, :created_at, :updated_at
json.url venue_url(venue, format: :json)
