class User < ActiveRecord::Base
    
    # jtinder slide sort order 
    default_scope { order('id DESC') }    

    # create association with users having friends
	has_many :friendships, dependent: :destroy
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
    
    # for paperclip gem
	has_attached_file :avatar,
					  :storage => :s3,
					  :style => { :medium => "370x370", :thumb => "100x100" }

    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    
    # "sign_in_from_omniauth(auth)" from sessions_controller.rb calls directly on the User class
	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
	end
    
    # creates a new user with the fields passed in by the auth hash.
	def self.create_user_from_omniauth(auth)
        create(
                
    		avatar: process_uri(auth['info']['image'] + "?width=9999"),
    		email: auth['info']['email'],
    		provider: auth['provider'],
    		uid: auth['uid'],
    		name: auth['info']['name'],
    		gender: auth['extra']['raw_info']['gender'],
    		date_of_birth: auth['extra']['raw_info']['birthday'],
    		location: auth['info']['location'],
    		bio: auth['extra']['raw_info']['bio']
		)
	end

    private

    #parses the uri with an https scheme.
    def self.process_uri(uri)
        image_url = URI.parse(uri)
        image_url.scheme = 'https'
        image_url.to_s
    end


end