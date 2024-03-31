class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [:index, :create, :new]
  before_action :require_editor_permissions, only: [:edit, :update]
  before_action :require_owner_permissions, only: [:destroy]

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
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user, role: :owner)

    if @password.save
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
    @user_password = current_user.user_passwords.find_by(password: @password)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def require_editor_permissions
    redirect_to @password unless @user_password.has_edit_permissions?
  end

  def require_owner_permissions
    redirect_to @password unless @user_password.has_owner_permissions?
  end
end