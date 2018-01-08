require 'rails_helper'

RSpec.describe Question, type: :model do
    let!(:question) { build(:question) }

    context 'validation tests' do
        it 'should ensure presence of user' do
            question.user = nil
            expect(question.save).to eql(false)
        end

        it 'should ensure presence of text' do
            question.text = nil
            expect(question.save).to eql(false)
        end
    end

    context 'scope tests' do
        it 'should create a question successfully' do
            question.save
            expect(Question.all.count).to eql(1)
        end

        it 'should not return deleted questions in default scope' do
            question.deleted_at = Time.now
            question.save
            expect(Question.all.count).to eql(0)
        end
    end

    context 'creation tests' do
        it 'should ensure creation of a revision' do
            question.save
            expect(Revision.all.count).to eql(1)
            expect(Revision.first[:revisable_id]).to eql(question.id)
            expect(Revision.first[:revisable_type]).to eql(question.class.to_s)
        end
    end
end
