# -*- ruby -*-
# frozen_string_literal: true

xml.status do
  xml.id status.to_param
  xml.code status.code
  xml.name status.name
end
