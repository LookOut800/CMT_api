class UsersController < ApplicationController
  before_filter :set_user, only: [:show,:update,:destroy]

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: user, status: :ok
    else
      head :unauthorized
    end
  end

  def logout
    head :ok
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    head :no_content
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation, :token)
  end

  def set_user
    @user = User.find(params[:id])
  endd
end