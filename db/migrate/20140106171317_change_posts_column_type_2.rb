class ChangePostsColumnType2 < ActiveRecord::Migration
  def change
      change_column :posts,:title,:text
  end
end
