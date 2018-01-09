RSpec.describe Question, type: :model do
    let!(:question) { FactoryBot.build(:question) }

    describe 'validation tests' do
        it 'should ensure presence of user' do
            question.user = nil
            expect(question.save).to eql(false)
        end

        it 'should ensure presence of text' do
            question.text = nil
            expect(question.save).to eql(false)
        end
    end

    describe 'scope tests' do
        it 'should not return deleted questions in default scope' do
            question.deleted_at = Time.now
            expect(question.save).to eql(true)
            expect(Question.all.count).to eql(0)
        end
    end

    describe 'success tests' do
        it 'should ensure total count to increase by one and creation of a revision' do
            question.save
            expect(Question.all.count).to eql(1)
            revision = Revision.last
            expect(revision).not_to be_nil
            expect(revision[:revisable_id]).to eql(question.id)
            expect(revision[:revisable_type]).to eql(question.class.to_s)
        end
    end
end
