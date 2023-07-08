require 'rails_helper'

RSpec.feature 'Categories Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }
  let!(:category1) { Category.create!(user:, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }

  before do
    sign_in user
    visit categories_path
  end

  scenario 'User can see names of all categories' do
    expect(page).to have_content(category1.name)
  end

  scenario 'User can see total amount of each category' do
    expect(page).to have_content(category1.operations.sum(:amount))
  end

  scenario 'User can navigate to transactions page' do
    click_link category1.name
    expect(current_path).to eq category_operations_path(category1)
  end

  scenario 'User can navigate to category/new page' do
    click_link 'NEW CATEGORY'
    expect(current_path).to eq new_category_path
  end
end
