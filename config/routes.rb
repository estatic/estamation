# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'estamations', :to => 'estamations#index', :as => :estamations
get 'estamations/add', :to => 'estamations#add', :as => :estamation_add
get 'estamations/edit/:id', :to => 'estamations#edit', :as => :estamation_edit
get 'estamations/project/:project_id', :to => 'estamations#index_w_project'
get 'estamations/:id', :to => 'estamations#show', :as => :estamation
post 'estamations', :to => 'estamations#create', :as => :estamation_create
put 'estamations/:id', :to => 'estamations#update', :as => :estamation_update
delete 'estamations/id', :to => 'estamations#destroys', :as => :estamation_delete

get 'estamations/:id/entry/new', :to => 'estamation_entry#new', :as => :new_estamation_entry
post 'estamations/:estamation_id/entry', :to => 'estamation_entry#create', :as => :estamation_entry_create

get 'projects/:project_id/estamations', :to => 'estamations#index_w_project', :as => :project_estamations

get 'projects/:project_id/estamations/:id', :to => 'estamations#show', :as => :project_estamation