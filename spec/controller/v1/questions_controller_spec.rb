RSpec.describe V1::QuestionsController, type: :controller do
  let(:question) { FactoryBot.build(:question) }

  describe 'GET #index' do
    it 'should get all questions' do
      question.save
      session[:user_id] = question.user.id
      get :index, params: { user_id: question.user.id }
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(question[:id])
    end
  end

  describe 'GET #show' do
    it 'should get the question info' do
      question.save
      get :show, params: { id: question.id }
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(question.to_json)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    context 'non logged in user' do
      it 'should redirect to signup path' do
        post :create, params: { user_id: user[:id], question: { text: question[:text] } }
        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body[:redirect_url]).to eq(v1_signup_path)
      end
    end

    context 'logged in user' do
      it 'should not create question if text is empty' do
        session[:user_id] = user[:id]
        post :create, params: { user_id: user.id, question: { text: '' } }
        expect(response).to have_http_status(:bad_request)
      end

      it 'should create a new question if valid params' do
        session[:user_id] = user[:id]
        post :create, params: { user_id: user.id, question: { text: question[:text] } }
        expect(response).to have_http_status(:created)
        expect(Question.last[:text]).to eq(question[:text])
      end
    end
  end

  describe 'PUT #update' do
    # context 'non logged in user' do
    #   it 'should redirect to signup path' do

    #     # put :cr, params: { user_id: user[:id], question: { text: question[:text] } }
    #     parsed_body = JSON.parse(response.body, symbolize_names: true)
    #     expect(response).to have_http_status(:unauthorized)
    #     expect(parsed_body[:redirect_url]).to eq(v1_signup_path)
    #   end
    # end

    # context 'logged in user' do
    #   it 'should not update if question is not present' do 
    #     question.save
    #     Question.delete_all
    #     put :update, params: { id: question[:id], question: { text: 'Is this updated question?' } }
    #     expect(response).to have_http_status :not_found
    #   end

    #   it 'should not update if text is empty' do
    #     question.save
    #     session[:user_id] = question.user.id
    #     put :update, params: { id: question[:id], question: { text: '' } }
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end

    #   it 'should update if all valid params' do
    #     question.save
    #     session[:user_id] = question.user.id
    #     updated_text = 'Is this the updated question?'
    #     put :update, params: { id: question[:id], question: { text: updated_text } }
    #     expect(response).to have_http_status(:ok)
    #     expect(Question.find(question[:id])[:text]).to eq(updated_text)
    #   end
    # end
  end

  # describe 'DELETE #destroy' do
  #   it 'should not delete if question does not belong to logged in user' do
  #     question.save
  #     new_user = FactoryBot.create(:user)
  #     session[:user_id] = new_user.id
  #     delete :destroy, params: { id: question[:id] }
  #     expect(response).to have_http_status :not_found
  #   end

  #   it 'should delete if question belong to logged in user' do
  #     question.save
  #     session[:user_id] = question.user.id
  #     delete :destroy, params: { id: question[:id] }
  #     expect(response).to have_http_status(:ok)
  #     expect(Question.find_by(id: question[:id])).to be_nil
  #   end
  # end
end
