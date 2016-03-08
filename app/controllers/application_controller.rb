class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end
    
    def logged_in?
      !!current_user
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:username] = user.username
        redirect '/positions'
      else
        redirect '/login'
      end
    end

    def current_user
      @current_user ||= User.find_by(:username => session[:username]) if session[:username]
    end






  end



end