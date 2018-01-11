RSpec.describe VotesController, type: :controller do
  let(:vote) { FactoryBot.build(:question_vote) }

  describe 'GET #index' do
    it 'should return all votes in JSON' do
      vote.save
      get :index

      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(parsed_body[0][:id]).to eq(vote[:id])
    end
  end

  describe 'GET #show' do
    it 'returns one vote in JSON format' do
      vote.save
      get :show, params: { id: vote[:id] }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(vote.to_json)
    end
  end

  # describe 'POST #create' do
  #   context 'non logged in user' do
  #     it 'should not create vote' do
  #       post :create, params: { vote: { value: vote[:value] } }
  #       parsed_body = JSON.parse(response.body, symbolize_names: true)
  #       expect(response).to have_http_status(:forbidden)
  #       expect(parsed_body[:redirect_url]).to eq(signup_path)
  #     end
  #   end
  # end
end
