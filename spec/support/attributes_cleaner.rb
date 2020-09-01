# frozen_string_literal: true

module AttributesCleaner
  def clean_unused_attributes(record)
    record.attributes.except("created_at", "updated_at")
  end
end
