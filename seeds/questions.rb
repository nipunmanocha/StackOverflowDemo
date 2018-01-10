module Questions
  def self.seed
    users = User.all
    users.each do |user|
      2.times do |i|
          Question.create(text: "#{user[:name]}'s Question number #{i + 1}", user: user)
      end
    end
  end
end
