class UsersController < ApplicationController
  before_action :require_login
  
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

  def matches
  end
end
