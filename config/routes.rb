Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/articles", to: "article#index"
  get "/articles/paginate", to: "article#article_page"
  

  post "/articles", to: "article#create"
  put  "/articles/:id", to: "article#update"
  delete "/articles/:id", to: "article#delete"



  get "/users", to: "user#index"
  get "/users/paginate", to: "user#user_page"
  
  post "/users", to: "user#create"
  post "/users/validate", to: "user#validate"

  put "/users", to: "user#update" 

end
