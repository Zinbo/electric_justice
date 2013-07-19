class AddAdminColumnToUsers < ActiveRecord::Migration
  def up
    change_column :characters, :primary, :boolean, :default => false
end

def down
    change_column :characters, :primary, :boolean, :default => nil
end
end
