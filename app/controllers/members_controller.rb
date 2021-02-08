class MembersController < ApplicationController
  def index
    # The index will return all members if a value is not provided by params
    @members = Member.search(params[:query])
  end
end
