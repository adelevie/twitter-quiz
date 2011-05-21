class SubmittedAnswersController < ApplicationController

	def update
		@submitted_answer = SubmittedAnswer.find(params[:id])
		@submitted_answer.update_attributes(params[:submitted_answer])

		@question = @submitted_answer.question
		@question.closed = 1
		@question.save
		
		@scoreboard_entry = ScoreboardEntry.find_or_create_by_quiz_id(@submitted_answer.quiz_id) do |se|
			se.answerer_id = @submitted_answer.answerer_id
		end
		@scoreboard_entry.deposit(@submitted_answer.question.points)
		@scoreboard_entry.save
		
		if params[:question_is_last?]
			redirect_to '/quizzes/'+@submitted_answer.question.quiz_id.to_s
		else	
			redirect_to '/questions/ask/'+params[:next_question_id].to_s
		end
	end
end
