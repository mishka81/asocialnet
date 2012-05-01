class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_back_or user
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = t("ctl.session.login_error")
      render "new"
    end
    
  end

  # DELETE
  def destroy
    sign_out
    redirect_to root_path
  end
end
