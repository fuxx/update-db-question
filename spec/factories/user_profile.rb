# frozen_string_literal: true
FactoryBot.define do
  factory :user_profile do
    display_name { Faker::FunnyName.name }
    field_a { Faker::Address.community }
    field_b { Faker::Address.street_name }
  end
end
