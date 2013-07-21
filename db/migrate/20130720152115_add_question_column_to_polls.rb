class AddQuestionColumnToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :question, :text
  end
end
