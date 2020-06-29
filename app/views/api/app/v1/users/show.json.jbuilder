# frozen_string_literal: true
json.extract!(
  user,
  :id,
  :email,
  :created_at,
  :updated_at
)
json.user_profile_attributes do
  json.partial! 'api/app/v1/user_profiles/show', user_profile: user.user_profile if user.user_profile.present?
end
