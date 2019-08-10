class Api::V1::MessagesController < ApplicationController
    before_action :message_params, only: [:create, :update]

    before_action :set_application
    before_action :set_chat
    before_action :set_message, only: [:show, :update]

    def index
        @messages = @chat.messages
    end

    def create
        MessageJob.perform_later 'create', params[:application_access_token], params[:chat_number], message_params
        render json: { number: @chat.messages.count + 1 }
    end

    def show
    end

    def update 
        MessageJob.perform_later 'update', params[:application_access_token], params[:chat_number], params[:number], message_params
        render json: { number: @message.number }
    end

    def find
        query = params[:q]
        @messages = @chat.messages.where("body LIKE :query", query: "%#{query}%")
    end

    private
        def message_params
            params.permit(:body)
        end
        def set_application
            @application = Application.where(access_token: params[:application_access_token]).first
        end
        def set_chat
            return render json: { error: OBJECT_NOT_FOUND, obj_type: 'application'} if @application.nil?
            if @application.chats.count > 0
                @chat = @application.chats.where(number: params[:chat_number], application: @application).first
                render json: { error: OBJECT_NOT_FOUND, obj_type: 'chat'} if @chat.nil?
            else
                render json: { error: "This application does not have any chats"}
            end
        end
        def set_message
            return render json: { error: OBJECT_NOT_FOUND, obj_type: 'chat'} if @chat.nil?
            if @chat.messages.count > 0
                @message = @chat.messages.where(number: params[:number], chat: @chat).first
                render json: { error: OBJECT_NOT_FOUND} if @message.nil?
            else
                render json: { error: "This chat does not have any messages"}
            end
        end

end
