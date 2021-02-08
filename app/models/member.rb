class Member < ApplicationRecord
   has_many :friendships
   has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  # Tried using postgres/ACtiveRecord array query using ANY? but only works with exact matches
  # The below method works, but is overly complex and makes too many calls
  # Will refactor this after tackling other requirements
  def self.search(search='')
    members = []
    if search.present?
      Member.all.each do |member|
        if member.tags.any?(/#{search}/)
          members << member
        end
      end
    else
      members = self.all
    end
    members
  end

  def friends
     (friendships.map{|friendship| friendship.friend} + inverse_friendships.map{|friendship| friendship.member}).compact
  end

  def friend?(user)
     friends.include?(user)
  end
end
