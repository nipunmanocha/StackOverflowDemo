RSpec.describe Answer, type: :model do
    let!(:answer) { FactoryBot.build(:answer) }

    describe 'validation tests' do
        it 'should ensure presence of user' do
            answer.user = nil
            expect(answer.save).to eql(false)
        end

        it 'should ensure presence of question' do
            answer.question = nil
            expect(answer.save).to eql(false)
        end

        it 'should ensure presence of text' do
            answer.text = nil
            expect(answer.save).to eql(false)
        end
    end

    describe 'scope tests' do
        it 'should not return deleted answers in default scope' do
            answer.deleted_at = Time.now
            expect(answer.save).to eql(true)
            expect(Answer.all.count).to eql(0)
        end
    end

    describe 'creation tests' do
        it 'should ensure total count to increase by one and creation of a revision' do
            answer.save
            expect(Answer.all.count).to eql(1)
            revision = Revision.last

            expect(revision).not_to be_nil
            expect(revision[:revisable_id]).to eql(answer.id)
            expect(revision[:revisable_type]).to eql(answer.class.to_s)
        end
    end
end
