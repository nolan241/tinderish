class HomeController < ApplicationController
  def index
    # redirect the users to the  root_path  if they're not logged in
    if current_user
      redirect_to users_path
    end  
  end
end
