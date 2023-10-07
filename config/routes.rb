Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tasks do
    member do
      patch 'toggle_status'
    end
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create]


  root 'static_pages#landing'
  # Defines the root path route ("/")
  # root "articles#index"

  # get all of a user's tasks
  get '/my_tasks', to: 'tasks#index', as: 'user_tasks'

  # get all of a user's tasks due today
  get '/today_tasks', to: 'tasks#today', as: 'today_tasks'

  # mark a task complete
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  # mark a task incomplete
  patch '/tasks/:id/incomplete', to: 'tasks#incomplete', as: 'incomplete_task'

  # render a form for a new task belonging to a user
  get '/tasks/new', to: 'tasks#new', as: 'new_task_form'
  
  # create a new task belonging to a user
  post '/tasks', to: 'tasks#create', as: 'create_user_task'
  
  # get one of a user's tasks
  get '/my_tasks/:id', to: 'tasks#show', as: 'show_user_task'
  
  # get one of a user's tasks to edit
  get '/my_tasks/:id/edit', to: 'tasks#edit', as: 'edit_user_task'
  
  # save the edited task
  patch '/my_tasks/:id', to: 'tasks#update_for_user', as: 'update_user_task'
  
  # delete a task
  delete '/my_tasks/:id', to: 'tasks#destroy_for_user', as: 'destroy_user_task'

  # display filtered user tasks
  get 'search_user_tasks', to: 'tasks#search_user_tasks', as:'search_user_tasks'

  # logout
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/login', to: 'sessions#new', as: 'new_user_session'
  post '/login', to: 'sessions#create', as: 'user_session'
  delete '/logout', to: 'sessions#destroy', as: 'destroy_user_session'
  get '/register', to: 'registrations#new', as: 'new_user_registration'
  post '/register', to: 'registrations#create', as: 'user_registration'

end
