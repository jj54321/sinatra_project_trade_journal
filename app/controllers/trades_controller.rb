class TradesController < ApplicationController

  get '/trades' do
    redirect_if_not_logged_in
    @trades = current_user.trades
    erb :'trades/index'
  end

  get '/trades/new' do
    redirect_if_not_logged_in
    erb :'trades/new'
  end

  post "/trades/new" do
    redirect_if_not_logged_in
    @trade = Trade.new
    @trade.entry = params[:entry]
    @trade.exit = params[:exit]
    @trade.profit_loss = params[:profit_loss]
    @trade.position_id = params[:position_id]
    @trade.save
    redirect "/trades"
  end

  get '/trades/:id' do
    redirect_if_not_logged_in
    @trade = current_user.trades.find_by_id(params[:id])
    erb :'trades/show'
  end

  get "/trades/:id/edit" do
    redirect_if_not_logged_in
    @trade = current_user.trades.find_by_id(params[:id])
    erb :'trades/edit'
  end

  post '/trades/:id' do
    redirect_if_not_logged_in
    @trade = current_user.trades.find_by_id(params[:id])
    @trade.entry = params[:entry]
    @trade.exit = params[:exit]
    @trade.profit_loss = params[:profit_loss]
    @trade.position_id = params[:position_id]
    @trade.save
    redirect "/trades/#{@trade.id}"
  end

  post '/trades/:id/delete' do
    redirect_if_not_logged_in
    @trade = current_user.trades.find_by_id(params[:id])
    @trade.delete
    redirect to '/positions'
 end

end