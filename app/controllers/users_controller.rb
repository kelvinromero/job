class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    result = RegisterUser.call(user_params: user_params)
    @user = result.user

    respond_to do |format|
      if result.success?
        format.html { redirect_to result.user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: result.user }
      else
        format.html { render :new }
        format.json { render json: result.message, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    result = UpdateUser.call(user: @user, user_params: user_params)
    respond_to do |format|
      if result.success?
        format.html { redirect_to result.user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: result.user }
      else
        format.html { render :edit }
        format.json { render json: result.user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    result = DestroyUser.call(user: @user)

    respond_to do |format|
      if result.success?
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      else
        format.html { redirect_to users_url, alert: result.message }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = FindUser.call(user_id: params[:id]).user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
