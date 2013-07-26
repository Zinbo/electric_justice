class CreateReceivedMessages < ActiveRecord::Migration
  def change
    create_table :received_messages do |t|
      t.references :received_sender
      t.references :received_recipient
      t.string :subject
      t.text :body
      t.boolean :deleted
      t.boolean :read
      
      t.timestamps
    end
  end
end
