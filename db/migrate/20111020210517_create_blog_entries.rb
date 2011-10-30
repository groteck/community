class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :preview, :default => 1500
      t.timestamps
    end
  end
end
