class Post < ActiveRecord::Base
	acts_as_commentable
	belongs_to :author, :class_name => "User", :foreign_key => :user_id

  has_many :post_categories
  has_many :categories, through: :post_categories

  scope :recent, order("id DESC")
  scope :hot, order("click_count DESC")

  after_create :update_info 

  def update_info
    update_from_embedly
  end

  def update_from_embedly

    link = self

    urls = [url]

    embedly_api = Embedly::API.new(:key => Setting.embedly_key)
    embedly_objs = embedly_api.oembed(:urls => urls)

    response_data = embedly_objs[0].marshal_dump

    link.title = response_data[:title]
    link.favicon_url = response_data[:favicon_url]
    link.provider_name = response_data[:provider_name]
    link.provider_url = response_data[:provider_url]
    link.description = response_data[:description]
    link.thumbnail_url = response_data[:thumbnail_url]

    link.save
  end
end
