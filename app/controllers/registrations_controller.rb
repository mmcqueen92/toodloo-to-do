class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    # Automatically sign in the user after successful registration
        sign_in(@user)
        redirect_to root_path, notice: 'Registration successful. You are now logged in.'
    else
        render :new
    end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
