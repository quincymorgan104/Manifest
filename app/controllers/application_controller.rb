require "./config/environment"
require "./app/models/mfst"
require "./app/models/user"
require "./app/models/like"
require "./app/models/comment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'manifestation'
  end
  
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #homepage requests start here
  
  
  get '/' do
    erb :index
  end

  #end homepage requests
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #about page start here
  
  get '/about' do
    erb :about
  end
  
  #end about page
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #login requests start here
  
  get '/login' do
    erb :login
  end
  
  
  post '/login' do
    @user= User.find_by(:email => params[:email])
    
    if @user==nil || @user.password != params[:password]
      redirect '/join'
    else 
      session[:user_id]=@user.id
      redirect '/feed'
    end
   end
    
  #end login requests
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #join requests start here
  
  get '/join'do
    erb :join
  end
    
  
  post '/join' do
    user= User.new(:email => params[:email])
    user.password = params[:password]
    @error = ""
    if !user.valid?
      @error="email is already taken, please try another"
      puts "error stuff"
      erb :join
    else
      user.save
      redirect '/login'
    end
  end
  
  #end join requests
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #feed requests start here  
  
  get '/feed' do
    @mfsts=Mfst.all.reverse
    erb :feed
  end
  
  post '/feed' do
    @mfst= Mfst.new(:user_id => session[:user_id], :content => params[:content])
    @mfst.save
    redirect '/feed'
  end
  
  #end feed requests
#----------------------------------------------------------------------------------------------------------------------------------------------------  
  #manifestation creation requests starts here
  
  get '/new_mfst' do
    erb :new_mfst
  end

  post '/new_mfst' do
    @user= User.find_by(:id =>  session[:user_id])
    @mfst= Mfst.new(:user_id => @user.id, :manifest => params[:manifest])
    @mfst.save
    redirect '/feed'
  end
  
  #end of manifestation creation
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #signout requests start here
  
  get '/signout' do
    session[:user_id]= nil
    redirect '/'
  end
  
  #end of signout requests
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #like mfst requests start here
  
  get '/like/:mfstid' do

    @mfst = Mfst.find_by(:id => params[:mfstid])
    
    if !Like.find_by(:user_id => session[:user_id])
      @like = Like.new(:user_id => session[:user_id], :mfst_id => params[:mfstid])
      @like.save
      @mfst.num_likes += 1
      @mfst.save
      redirect '/feed'
    else
      @like = Like.find_by(:user_id => session[:user_id])
      @like.destroy
      @mfst.num_likes -= 1
      @mfst.save
      redirect '/feed'
    end
  end
  
  
  #end of like requests
#----------------------------------------------------------------------------------------------------------------------------------------------------
  #comment requests start here
  
  
  get '/comment/:mfstid' do
    @mfst_id = params[:mfstid]
    erb :comment
  end
  
  post '/comment' do
    @comment = Comment.new(:content => params[:content], :mfst_id => params[:mfst_id])
    @comment.save
    puts "this is code"
    redirect '/feed'
  end
  
  get '/me' do
    erb :me
  end
  
  get '/post/:mfstid'do
    @mfst = Mfst.find_by(:id = params[:mfstid])
    @comments = []
    Comment.where(mfst_id: params[:mfstid]).find_each do |x|
      @comments.push(x)
    end
    erb :post
  end
  
  
  
end