
#["Debates", "Off-Topic", "Introductions"].each do |name|
  #Forum.create name: name
#end

Topic.destroy_all
User.destroy_all

User.create! username: "Captain Crunch", password: "secret", email: "lol@lol.com"
User.create! username: "Squirtle", password: "secret", email: "lol2@lol.com"

users = User.all

Forum.all.each do |forum|
  users.each do |user|
    10.times do
      t = forum.topics.build title: "Seeded Topic"
      p = t.posts.build body: "Seed body"
      t.creator = user
      t.save!
    end
  end
end

# Seed posts
Topic.all.each do |topic|
  3.times do
    users.each do |user|
      p = topic.posts.build body: "Seeded post."
      p.creator = user
      p.save!
    end
  end
end

