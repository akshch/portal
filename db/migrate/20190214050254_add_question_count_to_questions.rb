class AddQuestionCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :question_count, :integer
  end
end
