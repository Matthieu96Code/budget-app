require 'rails_helper'

RSpec.feature 'New Category Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }

  before do
    sign_in user
    visit new_category_path
  end

  scenario 'User can create a new category' do
    fill_in 'Name', with: 'Journey'
    fill_in 'Icon', with: 'https://picsum.photos/id/30/200/300'
    click_button 'Create Category'

    expect(current_path).to eq categories_path
    expect(page).to have_content('Category was successfully created.')
  end

  scenario 'User can see an error message if something wrong' do
    fill_in 'Name', with: nil
    fill_in 'Icon', with: 'https://picsum.photos/id/30/200/300'
    click_button 'Create Category'

    expect(current_path).to eq categories_path
    expect(page).to have_content "Name can't be blank"
  end
end