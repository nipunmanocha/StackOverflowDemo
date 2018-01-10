RSpec.describe AnswersController, type: :controller do
  let(:answer) { FactoryBot.build(:answer) }

  describe 'GET #index' do
    it 'should get all answers' do
      answer.save

      get :index
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(answer[:id])
    end
  end

  describe 'GET #show' do
    it 'returns one answer in JSON format' do
      answer.save
      get :show, params: { id: answer[:id] }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(answer.to_json)
    end
  end

  describe 'POST #create' do
    context 'non logged in user' do
      it 'should not create answer' do
        post :create, params: { answer: { text: answer[:text], question_id: answer.question.id } }
        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:forbidden)
        expect(parsed_body[:redirect_url]).to eq(signup_path)
      end
    end

    context 'logged in user' do
      let(:user) { FactoryBot.create(:user) }
      let(:question) { FactoryBot.create(:question) }
      it 'should not create answer if text is empty' do
        session[:user_id] = user[:id]
        post :create, params: { answer: { text: '', question_id: question[:id] } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should create a new answer if valid params' do
        session[:user_id] = user[:id]
        post :create, params: { answer: { text: answer[:text], question_id: question[:id] } }
        expect(response).to have_http_status(:created)
        expect(Answer.last[:text]).to eq(answer[:text])
      end
    end
  end

  describe 'PUT #update' do
    context 'non logged in user' do
    end

    context 'logged in user' do
      it 'should not update if answer is not present' do 
        answer.save
        Answer.delete_all
        put :update, params: { id: answer[:id], answer: { text: 'This is the updated answer' } }
        expect(response).to have_http_status :not_found
      end

      it 'should not update if text is empty' do
        answer.save
        session[:user_id] = answer.user.id
        put :update, params: { id: answer[:id], answer: { text: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should update if all valid params' do
        answer.save
        session[:user_id] = answer.user.id
        updated_text = 'This is the updated answer'
        put :update, params: { id: answer[:id], answer: { text: updated_text } }
        expect(response).to have_http_status(:ok)
        expect(Answer.find(answer[:id])[:text]).to eq(updated_text)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'should not delete if answer does not belong to logged in user' do
      answer.save
      new_user = FactoryBot.create(:user)
      session[:user_id] = new_user.id
      delete :destroy, params: { id: answer[:id] }
      expect(response).to have_http_status :not_found
    end

    it 'should delete if answer belong to logged in user' do
      answer.save
      session[:user_id] = answer.user.id
      delete :destroy, params: { id: answer[:id] }
      expect(response).to have_http_status(:ok)
      expect(Answer.find_by(id: answer[:id])).to be_nil
    end
  end
end
