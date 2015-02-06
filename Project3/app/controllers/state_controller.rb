class StateController < ApplicationController
	def filter
		#An array containing all states whose names
		#contain the substring query value in alphabetical order.
		#If no states match, generates appropriate message
		if (params[:substring] != nil) then
			# Lists the query value "substring"
			@substr = params[:substring]
			@matching_states = State.filter(@substr)
		end
	end
end
