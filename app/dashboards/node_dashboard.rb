# frozen_string_literal: true

require 'administrate/base_dashboard'

# Administrate Dashboard for the Node model.
class NodeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    zone: Field::BelongsTo,
    code: Field::String,
    name: Field::String,
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    status: Field::BelongsTo,
    logo: Field::ActiveStorage,
    body: Field::Text,
    address: Field::Text,
    latitude: Field::Number,
    longitude: Field::Number,
    hours: Field::String,
    notes: Field::Text,
    contact: Field::BelongsTo,
    devices: Field::HasMany,
    node_links: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[zone code name user status].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    zone code name user group status logo body address latitude longitude hours
    notes contact devices node_links created_at updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    zone code name user group status logo body address hours notes contact
  ].freeze

  def display_resource(node)
    "Node ##{node.to_param}"
  end
end
