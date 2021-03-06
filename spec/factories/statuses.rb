# frozen_string_literal: true

FactoryBot.define do
  factory :status do
    sequence(:name) { |n| "Test Status ##{n}" }
    color { 'text-muted' }
  end
end
