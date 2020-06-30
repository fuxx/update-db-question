# frozen_string_literal: true
require 'rails_helper'

def validate_response(user, user_profile, response)
  expect(response).to have_http_status(:success)
  expect(response.content_type).to eq("application/json; charset=utf-8")

  response_hash = JSON.parse(response.body).deep_symbolize_keys
  expect(response_hash).to be_a(Hash)
  # User
  expect(response_hash[:id]).to eq(user.id)
  expect(response_hash[:email]).to eq(user.email)
  # User profile
  expect(response_hash[:user_profile_attributes][:display_name]).to eq(user_profile.display_name)
  expect(response_hash[:user_profile_attributes][:field_a]).to eq(user_profile.field_a)
  expect(response_hash[:user_profile_attributes][:field_b]).to eq(user_profile.field_b)
end

RSpec.describe "Users", type: :request do
  describe "GET my user data from /users/me" do
    it "returns complete profile" do
      user = create(:user)
      user_profile = create(:user_profile, user: user)

      get api_app_v1_users_me_path
      validate_response(user, user_profile, response)
    end

    it "returns complete profile when complete profile is sent" do
      user = create(:user)
      user_profile = create(:user_profile, user: user)

      params = {
        email: user.email,
        user_profile_attributes: {
          display_name: user_profile.display_name,
          field_a: user_profile.field_a,
          field_b: user_profile.field_b,
        },
      }
      patch api_app_v1_users_me_path, params: params, as: :json
      validate_response(user, user_profile, response)
    end

    it "returns complete profile if only one parameter is sent" do
      user = create(:user)
      user_profile = create(:user_profile, user: user)

      params = {
        email: user.email,
        user_profile_attributes: {
          field_a: user_profile.field_a,
        },
      }
      patch api_app_v1_users_me_path, params: params, as: :json
      validate_response(user, user_profile, response)
    end
  end
end
