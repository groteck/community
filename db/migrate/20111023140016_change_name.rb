class ChangeName < ActiveRecord::Migration
  def up
    rename_column :comments, :blog_entrie_id, :blog_entry_id
  end

  def down
  end
end
