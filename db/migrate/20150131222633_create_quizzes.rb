class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :firstNum
      t.integer :secondNum
      t.boolean :attempted
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
