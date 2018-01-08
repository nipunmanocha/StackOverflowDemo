require 'rails_helper'

RSpec.describe User, type: :model do
    let!(:user) { build(:user) }

    context 'validation tests' do
        it 'ensures presence of name' do
            user.name = nil
            expect(user.save).to eql(false)
        end

        it 'ensures length of name cannot be more than 50' do
            user.name = 'a' * 51
            expect(user.save).to eql(false)
        end
    end

    context 'scope tests' do
        it 'should create a user successfully' do
            user.save
            expect(User.all.count).to eql(1)
        end

        it 'should not return deleted users in default scope' do
            user.deleted_at = Time.now
            user.save
            expect(User.all.count).to eql(0)
        end
    end
end
