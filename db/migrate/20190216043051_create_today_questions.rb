class CreateTodayQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :today_questions do |t|
      t.integer :question_id

      t.timestamps
    end
  end
end
