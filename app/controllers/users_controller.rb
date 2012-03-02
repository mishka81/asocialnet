class UsersController < ApplicationController


  # GET /users/new
  # shows the signup form
  def new
    @user = User.new
  end

  # GET /users/:id
  # shows a user's profile page
  def show
    @user = User.find(params[:id])
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
      render 'new'
    end
  end
end
