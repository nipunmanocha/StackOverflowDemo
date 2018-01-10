RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.build(:user) }

  describe 'GET #index' do
    it 'returns JSON array of all users' do
      user.save
      get :index
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(user[:id])
    end
  end

  describe 'GET #show' do
    it 'returns one user in JSON format' do
      user.save
      get :show, params: { id: user[:id] }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(user.to_json)
    end
  end

  describe 'POST #create' do
    context 'Invalid/Missing Parameters' do
      it 'should not allow user creation' do
        post :create, params: { user: { name: user[:name], email: user[:email] } }
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'Correct Parameters' do
      it 'should make a new user' do
        post :create, params: { user: { 
          name: user[:name], 
          email: user[:email], 
          password: '123456',
          password_confirmation: '123456' } }
  
        parsed_body = JSON.parse(response.body, symbolize_names: true)
  
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(parsed_body[:email]).to eq(user[:email])
        expect(User.last[:email]).to eq(user[:email])
      end
    end
  end

  describe 'PUT #update' do
    # context 'Invalid User' do
    #   it 'should not update' do
    #     user.save
    #     User.delete_all
    #     put :update, params: { id: user[:id] }

    #     expect(response).to have_http_status(:not_found)
    #   end
    # end

    # context 'User not logged in or trying to update other user info' do
    #   it 'should not update' do
    #     user.save
    #     put :update, params: {id: }
    #   end
    # end

    # User authentication has been commented out here
    context 'Valid User but Invalid/Missing update params' do
      it 'should not update' do
        user.save
        put :update, params: { id: user[:id], user: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.find(user[:id])[:email]).to eq(user[:email])
      end
    end

    context 'Valid User and correct parameters' do
      it 'should update' do
        user.save
        new_email = 'new_email@update.com'
        put :update, params: { id: user[:id], user: { name: 'Updated name', email: new_email } }

        expect(response).to have_http_status(:ok)
        expect(User.find(user[:id])[:email]).to eq(new_email)
      end
    end
  end

  describe 'DELETE #destroy' do
    # context 'Invalid User' do
    #   it 'should not delete' do
    #     user.save
    #     User.delete_all
    #     delete :destroy, params: { id: user[:id] }

    #     expect(response).to have_http_status(:not_found)
    #   end
    # end

    # context 'User not logged in or trying to delete other user info' do
    #   it 'should not delete' do
    #     user.save
    #     new_user = FactoryBot.create(:user)
        
    #     delete :destroy, params: { id: new_user[:id] }
    #     expect(response).to have_http_status(:unauthorized)
    #   end
    # end

    context 'Valid User' do
      it 'should delete' do
        user.save
        delete :destroy, params: { id: user[:id] }

        expect(response).to have_http_status(:ok)
        expect(User.find_by(id: user[:id])).to be_nil
      end
    end
  end
end
