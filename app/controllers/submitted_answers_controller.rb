class SubmittedAnswersController < ApplicationController

  def update
    @submitted_answer = SubmittedAnswer.find(params[:id])
    @submitted_answer.update_attributes(params[:submitted_answer])

    respond_to do |format|
      format.html do
        redirect_to '/questions/ask/'+params[:next_question_id].to_s
      end
      format.xml  { render :xml => @question, :status => :created, :location => @question }
     end
  end

  def mark_correct
    @submitted_answer = SubmittedAnswer.find(params[:id])
    #@submitted_answer.correct!
    @submitted_answer.correct = 0
    @submitted_answer.save
  end
end
