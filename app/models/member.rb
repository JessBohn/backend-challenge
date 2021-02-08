class Member < ApplicationRecord
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
end
