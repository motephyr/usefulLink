class Post < ActiveRecord::Base
	acts_as_commentable
	belongs_to :author, :class_name => "User", :foreign_key => :user_id
end
