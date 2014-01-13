class AddColumnPostCount < ActiveRecord::Migration
  def change
    add_column :posts , :click_count , :integer 
  end
end
