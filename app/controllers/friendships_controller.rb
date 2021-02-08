class FriendshipsController < ApplicationController

  # implement call to this create method from a form that gathers params[:name] and params[:website]
  # return to the index page
  def create
    # Friendship.create(member_id: params[:id], friend_id: Member.find_by(name: params[:name]))
    # sends back to Member#show where new friend should be listed
  end

  private
  # down here would implement params validation to weed out malicious params
end
