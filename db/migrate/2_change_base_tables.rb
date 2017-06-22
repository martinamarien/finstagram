class ChangeBaseTables < ActiveRecord::Migration

  def self.up
    create_table :followers do |t|
      t.references :user
      t.references :following
      t.timestamps
    end
    
    create_table :following do |t|
      t.references :user
      t.references :followedBy
      t.timestamps
    end
  end
    
end