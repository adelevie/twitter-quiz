TwitterQuiz::Application.routes.draw do
	devise_for :users
  devise_for :user do
    match '/user/sign_in/twitter' => Devise::Twitter::Rack::Signin
    match '/user/connect/twitter' => Devise::Twitter::Rack::Connect
  end

	match 'questions/ask/:id' => 'questions#ask'
	match 'submitted_answers/update' => 'submitted_answers#update'
	match 'quizzes/standings/:id' => 'quizzes#standings'

  resources :questions
  resources :quizzes



 	root :to => 'welcome#index'
end
