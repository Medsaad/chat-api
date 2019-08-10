class Api::V1::ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :update]

    def index
        @applications = Application.all
    end

    def create
        #Does not need a queuing since it has less request volume.
        @application = Application.new(application_params)
        @application.save
        if @application.errors.any?
            render json: {errors: @application.errors.full_messages}
        else
            render json: {access_token: @application.access_token}
        end
    end

    def show
    end

    def update
        @application.update(application_params)
        if @application.errors.any?
            render json: {errors: @application.errors.full_messages}
        else
            render json: {access_token: @application.access_token}
        end
    end

    private
        def application_params
            params.permit(:name)
        end
        def set_application
            @application = Application.where(access_token: params[:access_token]).first
            render json: { error: OBJECT_NOT_FOUND} if @application.nil?
        end

end
