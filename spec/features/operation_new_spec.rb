require 'rails_helper'

RSpec.feature 'New operation Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password') }
  let!(:category) { Category.create!(user:, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }
  let!(:operation) { Operation.create!(author: user, name: 'France', amount: 10, category_id: category.id) }

  before do
    sign_in user
    visit new_category_operation_path(category_id: category.id)
  end

  scenario 'User can create a new operation' do
    fill_in 'Name', with: 'France'
    fill_in 'Amount', with: 583.15
    check "operation_category_ids_#{category.id}"
    click_button 'Create Operation'

    expect(current_path).to eq category_operations_path(category)
    expect(page).to have_content('Operation was successfully created.')
  end

  scenario 'User can see an error message if something wrong' do
    fill_in 'Name', with: nil
    check "operation_category_ids_#{category.id}"
    click_button 'Create Operation'

    expect(current_path).to eq operations_path
    expect(page).to have_content "Name can't be blank"
  end
end
