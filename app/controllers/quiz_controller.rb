class QuizController < ApplicationController
  def index
  	#Index logic
  	@student = Student.first
    puts "testing"
  end

  def question1
    rndNum = Random.new()
    #rndNum = Random.new(42)
    @userAnswer = -1

  	#Clear out Quiz
    Quiz.delete_all

    #Create first question
    q1 = Quiz.new
    q1.firstNum = rndNum.rand(23..29)
    q1.secondNum = rndNum.rand(6..9)
    @symbol = ""
    if rndNum.rand(0..1) == 1
      @symbol = "+"
    else
      @symbol = "-"
    end
    
    q1.symbol = @symbol
    q1.attempted = false
    q1.correct = false
    q1.save

    #Create second question
    q2 = Quiz.new
    q2.firstNum = rndNum.rand(23..29)
    q2.secondNum = rndNum.rand(6..9)

    if rndNum.rand(0..1) == 1
      @symbol = "+"
    else
      @symbol = "-"
    end

    q2.symbol = @symbol
    q2.attempted = false
    q2.correct = false
    q2.save

    #Create third question
    q3 = Quiz.new
    q3.firstNum = rndNum.rand(23..29)
    q3.secondNum = rndNum.rand(6..9)

    if rndNum.rand(0..1) == 1
      @symbol = "+"
    else
      @symbol = "-"
    end

    q3.symbol = @symbol
    q3.attempted = false
    q3.correct = false
    q3.save

    #Get first question's data to be displayed
    @firstNum = Quiz.find(Quiz.first.id).firstNum
  	@secondNum = Quiz.find(Quiz.first.id).secondNum
    @symbol = Quiz.find(Quiz.first.id).symbol
  end

  def question1results
    #Check if user answered correctly
    @firstNum = Quiz.find(Quiz.first.id).firstNum
    @secondNum = Quiz.find(Quiz.first.id).secondNum
    @q = params[:q].to_i
    @answer = -1
    @userAnsweredCorrectly = false
    if Quiz.find(Quiz.first.id).symbol == "+"
      @answer = @firstNum + @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    else
      @answer = @firstNum - @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    end

    #Update Attempted and Correct
    @question = Quiz.find(Quiz.first.id)
    @question.attempted = true
    @question.correct = @userAnsweredCorrectly
    @question.save

    render :question1results
  end

  def question2
    #Get second question's data to be displayed
    @firstNum = Quiz.find(Quiz.first.id+1).firstNum
    @secondNum = Quiz.find(Quiz.first.id+1).secondNum
    @symbol = Quiz.find(Quiz.first.id+1).symbol
  end

  def question2results
    #Check if user answered correctly
    @firstNum = Quiz.find(Quiz.first.id+1).firstNum
    @secondNum = Quiz.find(Quiz.first.id+1).secondNum
    @answer = -1
    @q = params[:q].to_i
    #TODO: Use Symbol
    @userAnsweredCorrectly = false
    if Quiz.find(Quiz.first.id+1).symbol == "+"
      @answer = @firstNum + @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    else
      @answer = @firstNum - @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    end

    #Update Attempted and Correct
    @question = Quiz.find(Quiz.first.id+1)
    @question.attempted = true
    @question.correct = @userAnsweredCorrectly
    @question.save

    render :question2results
  end

  def question3
    #Get third question's data to be displayed
    @firstNum = Quiz.find(Quiz.first.id+2).firstNum
    @secondNum = Quiz.find(Quiz.first.id+2).secondNum
    @symbol = Quiz.find(Quiz.first.id+2).symbol
  end

  def question3results
    #Check if user answered correctly
    @firstNum = Quiz.find(Quiz.first.id+2).firstNum
    @secondNum = Quiz.find(Quiz.first.id+2).secondNum
    @answer = -1
    @q = params[:q].to_i
    #TODO: Use Symbol
    @userAnsweredCorrectly = false
    if Quiz.find(Quiz.first.id+2).symbol == "+"
      @answer = @firstNum + @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    else
      @answer = @firstNum - @secondNum
      @userAnsweredCorrectly = (@answer == @q)
    end

    #Update Attempted and Correct
    @question = Quiz.find(Quiz.first.id+2)
    @question.attempted = true
    @question.correct = @userAnsweredCorrectly
    @question.save

    render :question3results
  end

  def results
    @qAttempted = 0
    @qCorrect = 0
    @student = Student.first
    @origNumAtt = @student.numAttempted
    @origNumCor = @student.numCorrect

    #Go through each question
    Quiz.all.each do |q|
      if q.attempted
        #Update Quiz Numbers
        @qAttempted+=1
      end
      if q.correct
        #Update Quiz Numbers
        @qCorrect+=1
      end
    end

    #Update Student info
    @student.numAttempted = @origNumAtt + @qAttempted
    @student.numCorrect = @origNumCor + @qCorrect
    @student.save
    
    #Get numbers for Students Stats (e.g. 34/39)
    @sAttempted = @student.numAttempted
    @sCorrect = @student.numCorrect

    render :results
  end
end