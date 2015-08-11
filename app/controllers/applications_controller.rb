require "./app/config/enviroment"
require "./app/models/gif"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'manifestation'
  end
  
  get '/' do
    erb :index
  end
  
  get '/login' do
    erb :login
  end
  
  post '/login' do
    @user= User.find_by(:email => params[:email],:password => params[:password])
    if @user==nil
      redirect '/join'
    else 
      session[:user_id]=@user.id
      redirect '/feed'
   end
    
    get '/feed' do
    @mfsts=Mfst.all
    erb :feed
  end
  
    post '/new_mfst' do
    @user= User.find_by(:id =>  session[:user_id])
    @mfst= Mfst.new(:user_id => @user.id, :url => params[:url])
    @mfst.save
   

    redirect '/feed'
  end
    
  get '/signout' do
     session[:user_id]= nil
    redirect '/'
  end
  
  
end