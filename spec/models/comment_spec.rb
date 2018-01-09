RSpec.describe Comment, type: :model do
    let!(:question_comment) { FactoryBot.build(:question_comment) }
    let!(:answer_comment) { FactoryBot.build(:answer_comment) }

    describe "Validation Tests" do
        it 'should ensure presence of commentable' do
            question_comment.commentable = nil
            answer_comment.commentable = nil
            expect(question_comment.save).to eq(false)
            expect(answer_comment.save).to eq(false)
        end

        it 'should ensure presence of user' do
            question_comment.user = nil
            expect(question_comment.save).to eq(false)
        end

        it 'should ensure presence of text' do
            question_comment.text = nil
            expect(question_comment.save).to eq(false)
        end
    end

    describe 'Scope tests' do
        it 'should not return deleted questions in default scope' do
            question_comment.deleted_at = Time.now
            expect(question_comment.save).to eq(true)
            expect(Comment.all.count).to eq(0)
        end
    end
end
