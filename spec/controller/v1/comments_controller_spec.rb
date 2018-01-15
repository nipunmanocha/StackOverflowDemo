RSpec.describe V1::CommentsController, type: :controller do
  let(:question_comment) { FactoryBot.build(:question_comment) }
  let(:answer_comment) { FactoryBot.build(:answer_comment) }

  describe 'GET #index' do
    it 'should get all comments' do
      question_comment.save
      session[:user_id] = question_comment.commentable.user.id
      get :index, params: { question_id: question_comment.commentable_id }

      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(question_comment[:id])
    end
  end

  describe 'POST #create' do
    context 'non logged in user' do
      it 'should not create comment' do
        question_comment.save
        post :create, params: { question_id: question_comment.commentable_id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged in user' do
      it 'should not create comment if text is empty' do
        question = FactoryBot.create(:question)
        session[:user_id] = question.user.id
        post :create, params: { question_id: question[:id], comment: { text: '' } }
        expect(response).to have_http_status(:bad_request)
      end

      it 'should create comment if valid params' do
        question = FactoryBot.create(:question)
        session[:user_id] = question.user.id
        post :create, params: { question_id: question[:id], comment: { text: question_comment[:text] } }
        expect(response).to have_http_status(:created)
      end
    end
  end
end
