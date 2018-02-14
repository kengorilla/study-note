Rails.application.routes.draw do
  
  get "/" => "user#signup"
  post "/signup" => "user#create" 
  get "/signin"=>"user#home"
  post "login" =>"user#login"
  post "logout" => "user#logout"
  get "/user/index" => "user#index"
  get "/top" => "home#top"
  get "/note/new" =>"note#new"
  get "/note/index" => "note#index"
  get "/note/:id/edit" => "note#edit"
  get "/note/index" => "note#index"
  get "/note/:id/edit" => "note#edit"
  get "/post/new" => "post#new"
  get "/post/index" => "post#index"
  get "/post/:id/edit" => "post#edit"
  get "/post/:id/show" => "post#show"
  get "/comment/:id/edit" => "comment#edit"
  
  post "/post/create" => "post#create"
  post "/note/create" => "note#create"
  post "/note/:id/destroy" => "note#destroy"
  post "/note/:id/update" => "note#update"
  post "/post/:id/destroy" =>"post#destroy"
  post "/post/:id/update" => "post#update"
  post "/comment/:id/create" => "comment#create"
  post "/comment/:id/update" =>"comment#update"
  post "/comment/:id/destroy" => "comment#destroy"
  
  get "/quiz/home" => "quiz#home"
  post "/quiz/:id/check" => "quiz#check"
 
end
