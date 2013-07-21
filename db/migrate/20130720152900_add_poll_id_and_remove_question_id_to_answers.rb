class AddPollIdAndRemoveQuestionIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :poll_id, :integer
    remove_column :answers, :question_id
  end
end
