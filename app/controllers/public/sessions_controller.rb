# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  # before_action :ensure_normal_user, only: %i[update destroy]
  # before_action :user_state, only: [:create]
  # def ensure_normal_user
  #   if resource.email == 'guest@example.com'
  #     redirect_to root_path, alert: 'ゲストユーザーは更新・削除できません。'
  #   end
  # end 
    def after_sign_in_path_for(resource)
       recipes_path 
      # (current_customers.id)
    end
    def after_sign_out_path_for(resource)
       flash[:notice] = "Signed out successfully."
        root_path
    end
  # def guest_sign_in
  #   user = User.guest
  #   sign_in user
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  
  # def user_state
  # def reject_inactive_user!
    # if @customer
    # @user = User.find_by(email: params[:user][:email])
    # return if !@user
    # if @user.is_deleted?
    #     redirect_to new_user_registration_path
    # end
     
    # unless @user.valid_password?(params[:user][:password])
         
    #     redirect_to new_user_session_path
    # end
  # end
 
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
