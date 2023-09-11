class UsersController < ApplicationController
skip_before_action :authenticate_user, except: [:show, :update]  
skip_before_action :check_customer 
skip_before_action :check_owner

def index
  @users=User.all
  # render json: users
end
def show
  render json: @current_user
end

def login;
end

# def signup;
# end
def new
  @user=User.new
end
def create
  @user = User.new(user_params)
  if @user.save 
    UserMailer.with(user: @user).welcome_email.deliver_later
  else
    render json: { errors: @user.errors.full_messages}, status: :unprocessable_entity   
  end 
end
def edit 
  
end
def update
  if @current_user.update(user_params)
    render json: @current_user
  else
    render json: @current_user.errors.full_messages
  end
end

def user_params
  params.require(:user).permit(
    :name,
    :user_name,
    :email,
    :password,
    :password_confirmation,
    :image,
    :type
  )
end
end
