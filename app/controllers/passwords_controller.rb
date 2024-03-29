class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [:index, :create, :new]

  def index
    @passwords = current_user.passwords

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @password = current_user.passwords.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @password = current_user.passwords.create(password_params)

    if @password.persisted?
      redirect_to @password
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @password.update(password_params)
      redirect_to @password
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy
    redirect_to root_path
  end

  private
  def password_params
    params.require(:password).permit(:password, :username, :url)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end