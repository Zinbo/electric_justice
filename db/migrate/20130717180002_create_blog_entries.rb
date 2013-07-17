class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.text     "entry"
      t.timestamps
    end
  end
end
