ElectricJustice::Application.routes.draw do

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'


  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  match '/users/mailbox',                           to: 'mailboxes#show' ,                   as: :mailbox,            via: 'get'
  match '/users/mailbox/inbox/:id',                       to: 'mailboxes#received_message' ,          as: :show_received_message,            via: 'get'
  match '/users/mailbox/outbox/:id',                       to: 'mailboxes#sent_message' ,          as: :show_sent_message,            via: 'get'
  match '/users/mailbox/compose_message',                  to: 'mailboxes#compose_message' ,          as: :compose_message,            via: 'get'
  match '/users/mailbox/send_message',                  to: 'mailboxes#send_message' ,          as: :send_message,            via: 'post'
  match '/users/mailbox/delete_inbox',                  to: 'mailboxes#delete_selected_inbox' ,          as: :delete_selected_inbox_messages,            via: 'post'
  match '/users/mailbox/delete_outbox',                  to: 'mailboxes#delete_selected_outbox' ,          as: :delete_selected_outbox_messages,            via: 'post'
  match '/users/mailbox/delete_trash',                  to: 'mailboxes#delete_selected_trash' ,          as: :delete_selected_trash_messages,            via: 'post'

  mount Forem::Engine, :at => '/forums'

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, only: [:show, :index, :destroy]
  resources :polls, only: [:new, :index, :create, :edit, :update]
  
  authenticated :user do
    root :to => "blog_entries#overview"
  end

  root :to => "static_pages#home"
  
  match '/gallery',                           to: 'static_pages#gallery',                                     via: 'get'
  match '/progression',                       to: 'static_pages#progression',                                 via: 'get'
  match '/roster',                            to: 'static_pages#roster',                                      via: 'get'
  match '/requestbankitems',                  to: 'static_pages#request_bank_items',                          via: 'get'
  match '/voiceserverdetails',                to: 'static_pages#voice_server_details',                        via: 'get'
  

  match '/users/:id/characters',              to: 'characters#show' ,                   as: :alts,            via: 'get'
  match '/users/:id/characters',              to: 'characters#update' ,                                       via: 'post'
  match '/users/:id/characters/primary',      to: 'characters#primary',                 as: :make_primary,    via: 'post'
  match '/users/:id/characters',              to: 'characters#delete',                  as: :delete_alt,      via: 'delete'
  match '/polls/older',                       to: 'polls#older',                        as: :older_polls,     via: 'get'
  match '/polls/answer',                       to: 'polls#answer',                        as: :answer_polls,     via: 'post'

  match '/overview',                            to: 'blog_entries#overview',                                  via: 'get'
  match '/overview/new',                      to: 'blog_entries#new',                                           via: 'get'
  match '/overview/create',                      to: 'blog_entries#create',                                           via: 'post'
  match '/overview/edit/:id',                      to: 'blog_entries#edit',             as: :overview_edit,           via: 'get'
  match '/overview/update/:id',                      to: 'blog_entries#update',                                           via: 'put'
  
  match '/test', to: 'test#index', via: 'get'
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
