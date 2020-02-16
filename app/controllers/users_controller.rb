class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin

def index
  # unless current_user.admin?
  #   redirect_to root_path, :alert => "Access denied."
  # end
  @users = User.all
end

def show 
  #if current_user.admin?
    @user = User.find(params[:id])
  #else
    #redirect_to root_path, :alert => "Access denied."
   #end
end

def edit
  @user = User.find(params[:id])
end

def update
 @user = User.find(params[:id])
 @user.update(user_params)
 redirect_to users_path
end

def user
@users = User.all.where(:role => "user")
end

def admin 
@users = User.all.where(:role => "admin")
end

def moderator
  @users = User.all.where(:role => "moderator")
end


private

def set_admin
  unless current_user.admin?
  redirect_to root_path, :alert => "Access denied"
  end
end

def user_params
  params.require(:user).permit(:email, :first_name, :role)
end

end
