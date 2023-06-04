class Public::UsersController < ApplicationController
  def index
    @users = User.includes(:recipes).page(params[:page]).per(6).order(id: :ASC)
  end

  def show
    # @title = "#{@user.name}さんのページ"
    # if user_signed_in?
    #   @recipes = @user.recipes.includes([:favorites]).page(params[:page]).per(6)
    # else
    #   @recipes = @user.recipes.page(params[:page]).per(6)
    # end
  end

  def edit
    # @user = current_user
     @user = User.find(params[:id])
  end
  
  def update
        @user = current_user
        # binding.pry
    if  @customer.update(user_params)
        redirect_to users_my_page_path
    else 
        render :edit
    end
  end
  
  def favorites
    @title = "#{@user.name}さんがいいねしたレシピ"
    @recipes = @user.favorite_recipes.includes([:user], [:favorites]).page(params[:page]).per(6)
    render 'show_favorite'
  end
  
  def destroy
    @user.destroy
    redirect_to users_url, success: "「#{@user.name}を削除しました」"
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を完了しました"
    redirect_to root_path
  end


private
  
    def user_params
        params.require(:user).permit(:name, :email)
    end
      
    def is_matching_login_user
        user = User.find(params[:id])
      unless user.id == current_user.id
      redirect_to root_path
      end
    end
end

