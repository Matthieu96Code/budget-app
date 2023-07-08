require 'rails_helper'

RSpec.describe Category, type: :model do  
  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }
  let(:category) { Category.create!(user: user, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }
  let!(:operation1) { Operation.create!(author: user, name: 'France', amount: 583.15, category_id: category.id) }

  describe 'validations' do
    it 'should valid with all valid attributes' do
      expect(category).to be_valid
    end

    it 'should not valid if name is not present' do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'should not valid if icon is not present' do
      category.icon = nil
      expect(category).to_not be_valid
    end
  end

  describe 'associ    ations' do
    it 'should belong to correct user' do
      expect(category.user).to eql user
    end

    it 'should include correct operation' do
      expect(category.operations).to include(operation1)
    end
  end
end
