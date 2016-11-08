class User < ActiveRecord::Base
    
    # "sign_in_from_omniauth(auth)" from sessions_controller.rb calls directly on the User class
	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
	end
    
    # creates a new user with the fields provider, uid, name, gender, date_of_birth, location, bio passed in by the auth hash.
	def self.create_user_from_omniauth(auth)
        create(
          image: process_uri(auth['info']['image'] + "?width=9999"),
          email: auth['info']['email'],
          provider: auth['provider'],
          uid: auth['uid'],
          name: auth['info']['name'],
          gender: auth['extra']['raw_info']['gender'],
          date_of_birth: auth['extra']['raw_info']['birthday'].present? ? Date.strptime( auth['extra']['raw_info']['birthday'], '%m/%d/%Y') : nil,
          location: auth['info']['location'],
          bio: auth['extra']['raw_info']['bio']
        )
	end

end