class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/new
  # shows the signup form
  def new
    @user = User.new
  end

  # GET /users/:id
  # shows a user's profile page
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/:id/
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile successfully updated. "
      sign_in @user
      redirect_to @user
    else
      render "edit"
    end
  end

  # POST /users
  # User signup
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Account successfully created. Welcome to AsocialNet ! Here is your profile page."
      redirect_to @user
    else
      render "new"
    end
  end
  
  # DELETE users/:id
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "Your account has been deleted. "
    sign_out
    redirect_to root_path    
  end

  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
