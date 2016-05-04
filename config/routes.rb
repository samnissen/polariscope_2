Rails.application.routes.draw do
  resources :scheduled_tests

  get 'collections/index'

  resources :collections do
    resources :testsets do
      put :change_order, on: :member#, :constraints => {:ip => '127.0.0.1'}
      resources :test_actions do
        post :copy, on: :collection# , :constraints => {:ip => '127.0.0.1'}
        resources :object_identifiers do
          resources :test_action_data
          resources :object_identifier_siblings
        end
      end
    end
    resources :runs do
      resources :run_tests do
        resources :test_statuses
        resources :run_test_actions do
          resources :action_statuses
          resources :run_object_identifiers do
            resources :run_object_identifier_siblings
          end
        end
      end
    end
  end

  resources :environments

  resources :data_elements

  resources :data_element_values

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'collections#index'

  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session

    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

end
