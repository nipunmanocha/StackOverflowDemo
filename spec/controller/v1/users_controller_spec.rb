RSpec.describe V1::UsersController, type: :controller do
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
  
        expect(response).to have_http_status(:bad_request)
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
    context 'User not logged in' do
      it 'should redirect to login page' do
        user.save
        put :update, params: { id: user[:id], user: { name: 'Update name' } }

        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body[:redirect_url]).to eq(v1_signup_path)
      end
    end

    context 'User signed in' do
      context 'trying to update info of some other user' do
        it 'should not update' do
          user.save
          session[:user_id] = user.id
          new_user = FactoryBot.create(:user)
          
          put :update, params: { id: new_user[:id], user: { name: 'Update name' } }
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'trying to update to a existing email' do
        it 'should not update' do
          user.save
          session[:user_id] = user.id
          new_user = FactoryBot.create(:user)

          put :update, params: { id: user[:id], user: { email: new_user[:email] } }
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'successful update' do
        it 'should update' do
          user.save
          session[:user_id] = user.id
          new_email = 'abc@def.com'

          put :update, params: { id: user[:id], user: { email: new_email } }
          expect(response).to have_http_status(:ok)
          expect(User.find_by(id: user[:id])[:email]).to eq(new_email)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'User not logged in' do
      it 'should redirect to login page' do
        user.save
        delete :destroy, params: { id: user[:id] }

        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body[:redirect_url]).to eq(v1_signup_path)
      end
    end

    context 'User signed in' do
      context 'trying to delete some other user info' do
        it 'should not delete' do
          user.save
          session[:user_id] = user.id
          new_user = FactoryBot.create(:user)
          
          delete :destroy, params: { id: new_user[:id] }
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'successful delete' do
        it 'should delete' do
          user.save
          session[:user_id] = user.id
          delete :destroy, params: { id: user[:id] }
          expect(response).to have_http_status(:ok)
          expect(User.find_by(id: user[:id])).to be_nil
        end
      end
    end
  end
end
