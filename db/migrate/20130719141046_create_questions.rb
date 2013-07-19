class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id
      t.string :question
    end
    add_index :questions, :poll_id
  end
end
