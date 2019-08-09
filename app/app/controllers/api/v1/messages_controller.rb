class Api::V1::MessagesController < ApplicationController
    before_action :set_message, only: [:show, :update]

    def index
        @messages = Message.all
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
        def set_message
            @application = Application.where(access_token: params[:application_access_token]).first
            return render json: { error: OBJECT_NOT_FOUND} if @application.nil?
            if @application.chats.count > 0
                @chat = @application.chats.where(number: params[:chat_number], application: @application).first
                return render json: { error: OBJECT_NOT_FOUND} if @chat.nil?
                if @chat.messages.count > 0
                    @message = @chat.messages.where(number: params[:number], chat: @chat).first
                    render json: { error: OBJECT_NOT_FOUND} if @message.nil?
                else
                    render json: { error: "This chat does not have any messages"}
                end
            else
                render json: { error: "This application does not have any chats"}
            end
        end

end
