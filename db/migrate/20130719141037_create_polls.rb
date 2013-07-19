class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.timestamps
    end
    add_index :polls, :created_at
  end
end
