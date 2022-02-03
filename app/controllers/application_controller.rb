class ApplicationController < ActionController::Base
<<<<<<< Updated upstream
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    User.first
  end
=======
    def current_user
        User.first
      end
>>>>>>> Stashed changes
end
