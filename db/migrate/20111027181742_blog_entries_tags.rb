class BlogEntriesTags < ActiveRecord::Migration
  def change                   
    create_table :blog_entries_tags do |t|
                
      t.integer :tag_id        
      t.integer :blog_entry_id       

      t.timestamps
    end
  end
end 

