class CreateNewTables < ActiveRecord::Migration

  def change
  
    change_table (:posts) do |t|
      t.string :caption
      t.references :hashtag
    end

    change_table (:comments) do |t|
      t.references :hashtag
    end
    
    create_table :hashtags do |t|
        t.string :hashtag
        t.references :post
        t.timestamps
    end

  end

end