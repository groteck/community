class UsersController < ApplicationController
  before_filter :autorize_user, :except => [:show, :create, :new]
  before_filter :autorize_admin, :only => [:index, :delete]  
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    unless session[:user_id]
      @user = User.new
    else
      redirect_to root_path, notice: 'You are log in.'
    end
  end
   
   # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    params[:user][:access_level] = 0
    unless session[:user_id]
      @user = User.new(params[:user])
      unless User.last
        @user.access_level= 100
      end      
      respond_to do |format|
        if @user.save
          format.html { redirect_to root_url, :notice => "Signed up!" }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: 'You are log in.'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    
    @use = User.find(params[:id])
    unless User.find(session[:user_id]).access_level == 100
      params[:user][:access_level] = 0 
    end
    if User.find(session[:user_id]).access_level == 100
      params[:user][:old_password] = 0 
    end  
    if @user == User.find(session[:user_id]) or User.find(session[:user_id]).access_level == 100
        if @user.authenticate(params[:old_password]) or User.find(session[:user_id]).access_level == 100
          respond_to do |format|
            if @user.update_attributes(params[:user])
              format.html { redirect_to @user, notice: 'User was successfully updated.' }
              format.json { head :ok }
            else
              format.html { render action: "edit" }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        else
          flash.now.alert = "Invalid email or password"
          render "new"
        end
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'user delete'
   end
end
