require 'open-uri'
class Member < ApplicationRecord
   has_many :friendships
   has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
   # has_many :friends, through: :friendships
   # This method above will only return friendships where the specificed member is the member_id and not friend_id

   # has_many :friendships, ->(member) { where ("member_id = ? OR friend_id = ?", member.id, member.id) }
   # Tried to call all friendships where member is the member_id or friend_id

   # Before Member object is actually created, run set_headers method to scrub given website and create tags
   before_create :set_headers

  # Tried to create a scope that would find all members that containted the search terms
  # in their tags array, but this always return an empty Relation
  scope :relevant_members, -> (search) {where("tags @> ARRAY[?]", '%' + search + '%')}



  # Tried using postgres/ACtiveRecord array query using ANY? but only works with exact matches
  # The below method works, but is overly complex and makes too many calls
  # Will refactor this after tackling other requirements
  # Search method performed on all Members, regardless of the profile the user is on
  def self.search(search='')
    members = []
    if search.present?
      self.all.each do |member|
        if member.tags.any?(/#{search}/)
          members << member
        end
      end
    else
      members = self.all
    end
    members
  end

  # Started to implement search of non-friends where the beginning array of members to Search
  # would already be scoped to not include friends

  # def stranger_search(search='')
  #    members = []
  #    if search.present?
  #     self.where.each do |member|
  #        if member.tags.any?(/#{search}/)
  #         members << member
  #        end
  #     end
  #    else
  #     members = self.all
  #    end
  #    members
  # end

  def find_doc_selector(doc, selector)
     doc.css(selector).any? ? doc.css(selector).first.text.strip : nil
  end

  def friends
    (friendships.map{|friendship| friendship.friend} + inverse_friendships.map{|friendship| friendship.member}).compact
  end

  def friend?(user)
     friends.include?(user)
  end

  def friend_count
     friends.count
  end

  # Declare this method as private that it cannot be called outside of the model
  private
     def set_headers
        doc = Nokogiri::HTML(URI.open(website))
        h1 = find_doc_selector(doc, 'h1').present? ? find_doc_selector(doc, 'h1') : doc.css('title').first.text.strip
        h2 = find_doc_selector(doc, 'h2')
        h3 = find_doc_selector(doc, 'h3')
        tags << h1 << h2 << h3
        tags.compact
    end
end
