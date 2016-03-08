class UsersController < ApplicationController

  get '/' do
    erb :'/users/index'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/positions'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:username] = @user.username
      redirect '/positions'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/positions'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end