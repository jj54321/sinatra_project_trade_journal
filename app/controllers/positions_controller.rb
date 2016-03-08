class PositionsController < ApplicationController

  get '/positions' do
    redirect_if_not_logged_in
    @positions = current_user.positions
    erb :'positions/index'
  end

   get '/positions/new' do
    redirect_if_not_logged_in
    erb :'positions/new'
  end

  post "/positions/new" do
    redirect_if_not_logged_in
    @position = Position.new
    @position.instrument = params[:instrument]
    @position.status = "OPEN"
    @position.save
    current_user.positions << @position
    redirect "/positions"
  end

  get '/positions/:id' do
    redirect_if_not_logged_in
    @position = current_user.positions.find_by_id(params[:id])
    if @position
      erb :'positions/show'
    else
      redirect "/login?error=You have to be logged in to your account to do that"
    end
  end

  get '/positions/:id/edit' do
    redirect_if_not_logged_in
    @position = current_user.positions.find_by_id(params[:id])
    if @position
      erb :'positions/edit'
    else
      redirect '/'
    end
  end

  post '/positions/:id' do
    redirect_if_not_logged_in
    @position = current_user.positions.find_by_id(params[:id])
    if params[:close]
      @position.status = "closed"
    end
    @position.instrument = params[:instrument]
    @position.save
    redirect '/positions/:id'
  end

  post '/positions/:id/delete' do
    redirect_if_not_logged_in
    @position = current_user.positions.find_by_id(params[:id])
    @position.delete
    redirect to '/positions'
 end




end