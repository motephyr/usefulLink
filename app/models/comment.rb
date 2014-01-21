class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => "User", :foreign_key => :user_id


  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :author, :class_name => "User", :foreign_key => :user_id

  def editable_by?(user)
    user && user == author
  end
end
