class Api::V1::ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :update]

    def index
        @applications = Application.all
    end

    def create
        #queue
    end

    def show
    end

    def update
        #queue
    end

    private
        def set_application
            @application = Application.where(access_token: params[:access_token]).first
            render json: { error: OBJECT_NOT_FOUND} if @application.nil?
        end

end
