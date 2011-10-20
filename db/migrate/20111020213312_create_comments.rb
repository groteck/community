class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.datetime :update_at
      t.integer :user_id
      t.integer :blog_entrie_id

      t.timestamps
    end
  end
end
