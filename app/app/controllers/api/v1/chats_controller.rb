class Api::V1::ChatsController < ApplicationController
    before_action :set_application
    before_action :set_chat, only: [:show, :update]

    def index
        @chats = @application.chats
    end

    def create
        ChatJob.perform_later 'create', params[:application_access_token]
        render json: { number: @application.chats.count + 1 }
    end

    def show
    end

    # There is no item to update in chat!
    #def update
    #    ChatJob.perform_later :update chat_params
    #end

    private
        def set_application
            @application = Application.where(access_token: params[:application_access_token]).first
        end
        def set_chat
            return render json: { error: OBJECT_NOT_FOUND} if @application.nil?
            if @application.chats.count > 0
                @chat = @application.chats.where(number: params[:number], application: @application).first
                render json: { error: OBJECT_NOT_FOUND} if @chat.nil?
            else
                render json: { error: "This application does not have any chats"}
            end
        end

end
