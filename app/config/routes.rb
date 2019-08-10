Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :applications, param: :access_token, except: [:destroy] do
        resources :chats, param: :number, except: [:destroy] do
          resources :messages, param: :number, except: [:destroy]
          get 'messages/find/:q', to: 'messages#find'
        end
      end


    
    end
  end
end
