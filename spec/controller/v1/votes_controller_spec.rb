RSpec.describe V1::VotesController, type: :controller do
  let(:vote) { FactoryBot.build(:question_vote) }

  describe 'GET #index' do
    it 'should get all votes' do
      vote.save
      session[:user_id] = vote.voteable.user.id
      get :index, params: { question_id: vote.voteable_id }

      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(vote[:id])
    end
  end

  describe 'POST #create' do
    context 'non logged in user' do
      it 'should not create vote' do
        vote.save
        post :create, params: { question_id: vote.voteable_id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged in user' do
      it 'should not create vote if value is empty' do
        question = FactoryBot.create(:question)
        session[:user_id] = question.user.id
        post :create, params: { question_id: question[:id], vote: { value: nil } }
        expect(response).to have_http_status(:bad_request)
      end

      it 'should create vote if valid params' do
        question = FactoryBot.create(:question)
        session[:user_id] = question.user.id
        post :create, params: { question_id: question[:id], vote: { value: vote[:value] } }
        expect(response).to have_http_status(:created)
      end
    end
  end
end
