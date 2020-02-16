class WebpagesController < ApplicationController

  before_action :authenticate_user!, only: [:profile]

  def home
    @questions = Question.where(:status => "1").paginate(:page => params[:page], :per_page => 4)
  end

   def category 
   end

   def profile
   @user = current_user
   end
end
