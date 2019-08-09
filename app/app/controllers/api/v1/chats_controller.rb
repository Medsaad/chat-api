class Api::V1::ChatsController < ApplicationController
    before_action :set_chat, only: [:show, :update]

    def index
        @chats = Chat.all
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
        def set_chat
            @application = Application.where(access_token: params[:application_access_token]).first
            return render json: { error: OBJECT_NOT_FOUND} if @application.nil?
            if @application.chats.count > 0
                @chat = @application.chats.where(number: params[:number], application: @application).first
                render json: { error: OBJECT_NOT_FOUND} if @chat.nil?
            else
                render json: { error: "This application does not have any chats"}
            end
        end

end
