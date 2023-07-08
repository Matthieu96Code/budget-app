require 'rails_helper'

RSpec.describe Operation, type: :model do
  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }
  let(:category) { Category.create!(user: user, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }
  let!(:operation) { Operation.create!(author: user, name: 'France', amount: 583.15, category_id: category.id) }

  describe 'validations' do
    it 'should not valid if name is not present' do
      operation.name = nil
      expect(operation).to_not be_valid
    end

    it 'should not valid if amount is not present' do
      operation.amount = nil
      expect(operation).to_not be_valid
    end

    it 'should not valid if amount is negative' do
      operation.amount = -15
      expect(operation).to_not be_valid
    end
  end
end
