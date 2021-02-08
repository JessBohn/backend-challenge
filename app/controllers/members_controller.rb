class MembersController < ApplicationController
  def index
    # The index will return all members if a value is not provided by params
    @members = Member.search(params[:query])
  end

  def show
    @member = Member.find(params[:id])
  end

  # create form on index page would call to this action and then redirect to the index page upon completion
  # Usually you would also provided success or error messages to the user, so they know what happened
  def create
    @member = Member.create(name: params[:name], website: params[:website])
    redirect_to action: "index"
  end

  private
  # implement params validation and only permit query to prevent SQL injection and other malicious params
end
