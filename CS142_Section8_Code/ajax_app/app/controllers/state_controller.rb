class StateController < ApplicationController
	def filter
	end

	def filter_html
		@states = State.filter(params[:substring])
		render :partial => "html_filter"
	end

	def filter_json
		@states = State.filter(params[:substring])
		render :json => @states
	end
end
