# frozen_string_literal: true
module Api
  module App
    module V1
      class ApiController < ApplicationController
        protect_from_forgery with: :null_session
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

        def record_not_found
          render json: { message: 'Record Not Found!' }, adapter: :json_api, status: :not_found
        end
      end
    end
  end
end
