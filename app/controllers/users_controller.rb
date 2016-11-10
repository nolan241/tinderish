class UsersController < ApplicationController
  before_action :require_login
  
  #fetching all the users and assign them to the @users instance variable
	def index
	  @users = User.all
	end
	
  def edit
  end

  def profile
  end

  def matches
  end
end
