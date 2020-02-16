class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search]
  before_action :set_admin, except: [:new, :create, :show, :search]

  def index
    unless current_user.admin?
      redirect_to root_path, :alert => "Access deined."
    end
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.status = "1"
    @question.question_count = 1
    @question.save
    flash[:notice] = "Your question has been send successfully!"
    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    @question.update(:question_count => @question.question_count + 1)
    @answer = Answer.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def search
    @questions = Question.search(params[:search]).paginate(:page => params[:page], :per_page => 1)
  end

  def accepted
    @questions = Question.all.where(:status => "1")
  end

  def question_pending
    @questions = Question.all.where(:status => "0")
  end

  def question_rejected
    @questions = Question.all.where(:status => "-1")
  end

  def today
    TodayQuestion.destroy_all
    question = Question.where(:title => params[:todayquestion]).first
    @question_today = TodayQuestion.create!(:question_id => question.id)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_admin
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied"
    end
  end

  def question_params
    params.require(:question).permit(:title, :body, :category_list, :tag_list, :name, :status)
  end
end
