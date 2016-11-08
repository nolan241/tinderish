class SessionsController < ApplicationController
	
	def create
		auth = request.env["omniauth.auth"]
		session[:omniauth] = auth.except('extra')

	    #"sign_in" the user by calling a method named "sign_in_from_omniauth" on the User model and pass in the auth hash as an argument.
	    # if the sign_in_from_omniauth(auth) method works fine it will return a user object and, if so, let's assign that user id to a session variable named "user_id"
		user = User.sign_in_from_omniauth(auth)
		session[:user_id] = user.id
		redirect_to root_url, notice: "SIGNED IN"
	end
	
	def destroy
		session[:user_id]  = nil
		session[:omniauth] = nil
		redirect_to root_url, notice: "SIGNED OUT"
	end	
end
