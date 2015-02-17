class AddSymbolToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :symbol, :string
  end
end
