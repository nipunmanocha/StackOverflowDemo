RSpec.describe Vote, type: :model do
    let(:question_vote) { FactoryBot.build(:question_vote) }
    let(:answer_vote) { FactoryBot.build(:answer_vote) }

    describe "Validation Tests" do
        it 'should ensure presence of voteable' do
            question_vote.voteable = nil
            answer_vote.voteable = nil
            expect(question_vote.save).to eq(false)
            expect(answer_vote.save).to eq(false)
        end

        it 'should ensure presence of user' do
            question_vote.user = nil
            expect(question_vote.save).to eq(false)
        end

        it 'should ensure presence of value' do
            question_vote.value = nil
            expect(question_vote.save).to eq(false)
        end
    end

    describe 'Scope tests' do
        it 'should not return deleted votes in default scope' do
            question_vote.deleted_at = Time.now
            expect(question_vote.save).to eq(true)
            expect(Vote.all.count).to eq(0)
        end
    end
end
