require 'rails_helper'

RSpec.describe Question, type: :model do
    before (:each) do
        @question = Question.create!(
            text: 'What is RoR?',
            user_id: 1
        )
    end

    # describe "creation" do
    #     it "should have one item after being created" do
    #         expect(Question.all.count).to eq(1)
    #     end
    # end
end
