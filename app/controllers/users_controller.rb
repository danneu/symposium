class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end
  def edit
    @user = current_user
  end
  def update
    @user = current_user
    @user.email = params[:user][:email]
    password = params[:user][:password]
    confirmation = params[:user][:password_confirmation]
    if password != confirmation && !password.empty?
      flash[:error] = "Passwords don't match or are invalid."
      redirect_to edit_user_path(@user), error: "Password fail." and return
    end

    if !password.empty? && password == confirmation
      @user.password = password
    end

    if @user.save!
      redirect_to @user, notice: "Account updated."
    else
      render :edit
    end
  end
end
