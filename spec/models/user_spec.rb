RSpec.describe User, type: :model do
    let!(:user) { FactoryBot.build(:user) }

    describe 'validations' do
        context 'name validations' do
            it 'should ensure presence of name' do
                user.name = nil
                expect(user.save).to eql(false)
            end

            it 'should ensure length of name cannot be more than 50' do
                user.name = 'a' * 51
                expect(user.save).to eql(false)
            end
        end

        context 'email validations' do
            it 'should ensure presence of email' do
                user.email = nil
                expect(user.save).to eql(false)
            end

            it 'should ensure email cannot be more than 255 chars' do
                user.email = ('a' * 246) + '@gmail.com'
                expect(user.save).to eql(false)
            end

            it 'should ensure email should follow a particular format' do
                demo_emails = ['abcd', 'abcd@fgh', '#ddd', '@gmail.com']
                demo_emails.each do |email|
                    user.email = email
                    expect(user.save).to eql(false)
                end
            end

            it 'should ensure uniqueness of email' do
                user.save
                expect { FactoryBot.create(:user, email: user.email) }.to raise_error(ActiveRecord::RecordInvalid)
            end

            it 'should ensure case insenstivity of email' do
                user.save
                expect { FactoryBot.create(:user, email: user.email.upcase) }.to raise_error(ActiveRecord::RecordInvalid)
            end
        end
    end

    describe 'callback tests' do
        it 'should downcase email before save' do
            user.email = 'ABcdE@GMail.cOm'
            expect(user.save).to eql(true)
            expect(User.first[:email]).to eql(user.email.downcase)
        end
    end

    describe 'scope tests' do
        it 'should not return deleted users in default scope' do
            user.deleted_at = Time.now
            expect(user.save).to eql(true)
            expect(User.all.count).to eql(0)
        end
    end

    describe 'success tests' do
        it 'should increase User count by 1 on successful save' do
            user.save
            expect(User.all.count).to eql(1)
        end
    end
end
