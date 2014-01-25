# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :text
#  url           :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  description   :text
#  thumbnail_url :string(255)
#  favicon_url   :string(255)
#  provider_name :string(255)
#  provider_url  :string(255)
#  click_count   :integer
#

class Post < ActiveRecord::Base
	acts_as_commentable
	belongs_to :author, :class_name => "User", :foreign_key => :user_id

  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :url,:presence =>true, :uniqueness => true,:format => URI::regexp(%w(http https))

  scope :recent, order("created_at DESC")
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

  def editable_by?(user)
    user && user == author
  end
end
