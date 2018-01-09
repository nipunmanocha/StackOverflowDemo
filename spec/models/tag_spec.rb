RSpec.describe Tag, type: :model do
  let(:tag) { FactoryBot.build(:tag) }

  describe 'Validation Test' do
    it 'should ensure presence of value' do
      tag.value = nil
      expect(tag.save).to eq(false)
    end
  end

  describe 'Scope Test' do
    it 'should not return deleted tags in default scope' do
      tag.deleted_at = Time.now
      expect(tag.save).to eq(true)
      expect(Tag.all.count).to eq(0)
    end
  end
end
