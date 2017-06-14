class SessionsController < ApplicationController
  def new
    # ログイン画面を返すだけのアクション
  end
  def create
    # ログイン処理を担当するアクション
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました.'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました.'
      render 'new'
    end
  end
  def destroy
    # ログアウト処理を担当するアクション
  end

  private
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
