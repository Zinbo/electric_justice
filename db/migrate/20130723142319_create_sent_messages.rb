class CreateSentMessages < ActiveRecord::Migration
  def change
    create_table :sent_messages do |t|
      t.references :sent_sender
      t.references :sent_recipient
      t.string :subject
      t.text :body
      
      t.timestamps
    end
  end
end
