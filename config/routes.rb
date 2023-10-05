Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tasks
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :users, controllers: { sessions: 'sessions' } do
    delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
  end

  # get all of a user's tasks
  get '/my_tasks', to: 'tasks#index_for_user', as: 'user_tasks'

  # get all of a user's tasks due today
  get '/today_tasks', to: 'tasks#today_for_user', as: 'today_tasks_for_user'

  # mark a task complete
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  # mark a task incomplete
  patch '/tasks/:id/incomplete', to: 'tasks#incomplete', as: 'incomplete_task'

  # render a form for a new task belonging to a user
  get '/tasks/new', to: 'tasks#new_for_user', as: 'new_user_task'
  
  # create a new task belonging to a user
  post '/tasks', to: 'tasks#create_for_user', as: 'create_user_task'
  
  # get one of a user's tasks
  get '/my_tasks/:id', to: 'tasks#show_for_user', as: 'show_user_task'
  
  # get one of a user's tasks to edit
  get '/my_tasks/:id/edit', to: 'tasks#edit_for_user', as: 'edit_user_task'
  
  # save the edited task
  patch '/my_tasks/:id', to: 'tasks#update_for_user', as: 'update_user_task'
  
  # delete a task
  delete '/my_tasks/:id', to: 'tasks#destroy_for_user', as: 'destroy_user_task'

  # render a search form for the user to filter through their tasks
  get '/search_user_tasks_form', to: 'tasks#search_user_tasks_form', as: 'search_user_tasks_form'

  # display filtered user tasks
  get 'search_user_tasks', to: 'tasks#search_user_tasks', 'search_user_tasks'

end
