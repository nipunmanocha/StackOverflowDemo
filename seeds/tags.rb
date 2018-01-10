module Tags
  def self.seed
    10.times { |i| Tag.create(value: "Tag #{i + 1}", description: "This is tag number #{i + 1}") }

    questions = Question.all[0..4]
    tags = Tag.all[0..5]

    questions.each do |question|
        question.tags = tags
    end
  end
end
