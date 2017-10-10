Rails.application.routes.draw do
  get 'game', to: "pages#game"
  get 'score', to: "pages#score"
  get 'grid', to: 'pages#grid'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
