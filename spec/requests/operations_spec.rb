require 'rails_helper'

RSpec.describe 'Operation', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'user01', email: 'user01@gmail.com', password: 'password01') }
  let(:category) { Category.create!(user: user, name: 'Journey', icon: 'https://picsum.photos/id/30/200/300') }
  let!(:operation) { Operation.create!(author: user, name: 'France', amount: 583.15, category_id: category.id) }

  let(:valid_params) { { category_ids: [category.id], name: 'Dubai', amount: 634.20 } }
  let(:invalid_params) { { category_ids: [], name: 'Thailande', amount: 602.38 } }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it 'should return a 200 OK status' do
      get new_category_operation_path(category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render operations/new template' do
      get new_category_operation_path(category)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new operation' do
        expect do
          post category_operations_path(category), params: { operation: valid_params }
        end.to change(category.operations, :count).by(1)
      end

      it 'should redirect to corresponding category/operation/index page' do
        post category_operations_path(category), params: { operation: valid_params }
        expect(response).to redirect_to(category_operations_path(category))
      end
    end

    context 'with invalid parameters' do
      it 'should not create a new operation' do
        expect do
          post category_operations_path(category), params: { operation: invalid_params }
        end.to change(category.operations, :count).by(0)
      end
    end
  end
end
