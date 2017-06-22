class AddBioToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :bio, :string
  end
end