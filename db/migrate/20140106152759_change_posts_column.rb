class ChangePostsColumn < ActiveRecord::Migration
  def change
    remove_column :posts, :content
    add_column :posts, :description,:string
    add_column :posts, :thumbnail_url,:string
    add_column :posts, :favicon_url,:string
    add_column :posts, :provider_name,:string
    add_column :posts, :provider_url,:string
  end
end
