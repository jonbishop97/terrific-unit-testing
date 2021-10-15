Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # add mapping for finding similar movies by director
  get 'movies/:id/matching_directors', to: 'movies#show_same_directors', as: :search_directors_path
end