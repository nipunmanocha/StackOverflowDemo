require 'rails_helper'

RSpec.describe User, type: :model do
    # before (:each) do
    #     @user = User.create(
    #         name: 'Nipun', 
    #         email: 'nipun.manocha@1mg.com',
    #         password: '123456',
    #         password_confirmation: '123456'
    #     )
    # end
    # let(:user) { build(:user) }

    describe "creation" do
        it "should have one item after being created" do
            create(:user)
            expect(User.all.count).to eq(1)
        end
    end
end
