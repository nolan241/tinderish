class UsersController < ApplicationController
  before_action :require_login
	#set user before allowing access to user settings
	before_action :set_user, only:[:edit, :profile, :update, :destroy, :get_email]
	
  # old fetching all the users and assign them to the @users instance variable.... removed @users = User.all
  # 
	def index
	  # getting the users, on the index action, according with the url params sent via the Plugin. 
	  # using javascript response in index.js.erb under the views/users folder.
      if params[:id]
        @users = User.where('id < ?', params[:id]).limit(2)
      else
        @users = User.all.limit(2)
      end

    respond_to do |format|
      format.html
      format.js
    end
	    
	end	  
	
  def edit
  end

  def profile
  end

  def update
		if @user.update(user_params)
			respond_to do |format|
				format.html {redirect_to users_path}
			end
		else
			redirect_to edit_user_path(@user)
		end
	end
	
    def destroy
		if @user.destroy
			redirect_to root_path
			session[:user_id]  = nil
			session[:omniauth] = nil
		else
			redirect_to edit_user_path(@user)
		end
	end

  #variable @matches joins all the ACTIVE friendships and inverse_friendships that the user has which will give the total amount of matches they have.
  def matches
    @matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
  end

  def get_email
    respond_to do |format|
      format.js 
    end
  end

	private
  
  #find the user to edit 
	def set_user
		@user = User.find(params[:id])
	end
  
  #set params for user settings to be edited in update
	def user_params
		params.require(:user).permit(:interest, :bio, :avatar, :location, :date_of_birth)
	end  
  
end
