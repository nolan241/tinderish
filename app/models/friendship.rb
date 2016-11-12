class Friendship < ActiveRecord::Base
    # friendship  belongs_to  a user and belongs to a friend. however a friend it's also a user, has we can't have two belongs_to  a user relationship on the same model we must say that it belongs to a friend which corresponds to the class User. by adding has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy to the user
    belongs_to :user
	belongs_to :friend, class_name: "User"
end