require 'rails_helper'

RSpec.feature 'Transactions Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }
  let(:category) { Category.create!(user:, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }
  let!(:operation1) { Operation.create!(author: user, name: 'France', amount: 583.15, category_id: category.id) }
  let!(:operation2) { Operation.create!(author: user, name: 'England', amount: 612.46, category_id: category.id) }

  before do
    sign_in user
    visit category_operations_path(category)
  end

  scenario 'User can see the list of operations' do
    expect(page).to have_content(operation1.name)
    expect(page).to have_content(operation2.name)
  end

  scenario 'User can see operations ordered by most recent' do
    expect(page.all('.card-operation').first).to have_content(operation2.name)
    expect(page.all('.card-operation').last).to have_content(operation1.name)
  end

  scenario 'User can see total amount for the category' do
    expect(page).to have_content("#{category.operations.sum(:amount)} $")
  end

  scenario 'User can navigate to new transaction page' do
    click_link 'NEW OPERATION'
    expect(current_path).to eq new_category_operation_path(category)
  end
end
