# frozen_string_literal: true
module Api
  module App
    module V1
      class UsersController < Api::App::V1::ApiController
        before_action :set_current_user

        # Called to get the current logged in users profile
        def me
          respond_to do |format|
            format.json { render 'api/app/v1/users/show', status: :ok, locals: { user: @current_user } }
          end
        end

        # Called when user wants to set his avatar
        def update
          respond_to do |format|
            if @current_user.update(update_user_params)
              format.json { render 'api/app/v1/users/show', status: :ok, locals: { user: @current_user } }
            else
              render json: @current_user.errors, status: :unprocessable_entity
            end
          end
        end

        private

        def set_current_user
          @current_user = User.find(1)
        end

        def update_user_params
          params.require(:user).permit(
            :email,
            :password,
            user_profile_attributes: [:display_name, :field_a, :field_b]
          )
        end
      end
    end
  end
end
