class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.string :title
      t.text :content
      t.integer :tag_id
      t.integer :user_id
      t.datetime :updated_at

      t.timestamps
    end
  end
end
