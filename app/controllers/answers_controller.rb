class AnswersController < ApplicationController
  
  before_action :authenticate_user!

  before_action :set_admin, except: [:create]




   def create
    @answer = current_user.answers.new(answer_params)
    @answer.status = "0"
    @answer.save
    flash[:notice] = "Your answer has been send successfully!"
    redirect_to question_path(params[:answer][:question_id])
   end

   def index
    @answers = Answer.all
   end

   def edit
    @answers = Answer.find(params[:id])
   end

   def show 
    @question = Question.find(params[:id])
   end

   def update
     @answer = Answer.find(params[:id])
   if @answer.update(answer_params)
      redirect_to  answers_path
   end
   end

   def approved
     @answers = Answer.all.where(:status => "1")
   end

   def pending
     @answers = Answer.all.where(:status => "0")
   end
   
   def rejected
     @answers = Answer.all.where(:status => "-1")
   end


   private
   
   def set_admin
    unless current_user.admin?
    redirect_to root_path, :alert => "Access denied"
    end
  end


   def answer_params
    params.require(:answer).permit(:description, :status, :question_id, :user_id)
   end 
end
