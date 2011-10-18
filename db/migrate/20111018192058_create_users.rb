class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :access_level, :null => false, :default => 0

      t.timestamps
    end
  end
end
