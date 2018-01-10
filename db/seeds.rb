require_relative '../seeds/users'
require_relative '../seeds/questions'
require_relative '../seeds/answers'
require_relative '../seeds/votes'
require_relative '../seeds/comments'
require_relative '../seeds/tags'

Users.seed
Questions.seed
Answers.seed
Votes.seed
Comments.seed
Tags.seed
