# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Member.create([{name: "Jessica Bohn", website: "https://www.everlywell.com/blog/categories/news-and-info/"},
                {name: "Sasha Fierce", website: "https://news.nike.com/"},
                {name: "Jimmy Choo", website: "https://www.theshoesnobblog.com/"},
                {name: "Shawn Murray", website: "https://www.nasa.gov/news/releases/latest/"}])

Friendship.create([{member_id: 1, friend_id: 4}, {member_id: 2, friend_id: 3}, {member_id: 1, friend_id: 2}])
