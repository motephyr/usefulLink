class Link < ActiveRecord::Base
  scope :recent, order("id DESC")

  belongs_to :post
  belongs_to :user

  after_create :update_info

  def update_info
    delay.update_from_embedly
  end

  def update_from_embedly

    link = self

    urls = [url]

    embedly_api = Embedly::API.new(:key => Setting.embedly_key)
    embedly_objs = embedly_api.oembed(:urls => urls)

    response_data = embedly_objs[0].marshal_dump

    link.title = response_data[:title]
    link.link_type = response_data[:type]
    link.author_name = response_data[:author_name]
    link.author_url = response_data[:author_url]
    link.provider_name = response_data[:provider_name]
    link.provider_url = response_data[:provider_url]
    link.description = response_data[:description]
    link.thumbnail_url = response_data[:thumbnail_url]

    link.save
  end
end


