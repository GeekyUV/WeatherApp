class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.password == params[:session][:password]
      session[:user_id] = user.id
      redirect_to '/welcome'
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
