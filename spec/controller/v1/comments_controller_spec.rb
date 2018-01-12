RSpec.describe V1::CommentsController, type: :controller do
  let(:question_comment) { FactoryBot.build(:question_comment) }
  let(:answer_comment) { FactoryBot.build(:answer_comment) }

  describe 'GET #index' do
    it 'should get all comments' do
      question_comment.save
      answer_comment.save
      get :index, params: { question_id: question_comment.commentable_id }
      
    end
  end
end
