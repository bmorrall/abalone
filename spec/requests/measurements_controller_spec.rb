require 'rails_helper'

describe MeasurementsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "GET index", :aggregate_failures do
    it 'should have response code 200 for admin user' do
      user.update(role: 'admin')

      get measurements_path
      expect(response).to have_http_status(:success)
    end

    it 'should have response code 200 for non-admin user' do
      get measurements_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it 'should have response code 200 for admin user' do
      measurement_id = FactoryBot.create(:measurement).id
      user = create(:user, role: "admin")
      sign_in user
      get measurement_path(measurement_id)

      expect(response).to have_http_status(:success)
    end

    it 'should have response code 200 for admin user' do
      measurement_id = FactoryBot.create(:measurement).id
      sign_in user
      get measurement_path(measurement_id)

      expect(response).to have_http_status(:success)
    end
  end

  describe '#edit', :aggregate_failures do
    it 'should have response code 200 for admin user editing for own organization' do
      my_org = FactoryBot.create(:organization, id: 1, name: "My org")
      user = create(:user, role: "admin", organization: my_org)
      measurement = FactoryBot.create(:measurement, organization: my_org)

      sign_in user

      get edit_measurement_path(measurement)

      expect(response).to have_http_status(200)
    end

    it 'should have response code 302 for admin user editing for other organization' do
      my_org = FactoryBot.create(:organization, id: 1, name: "My org")
      other_org = FactoryBot.create(:organization, id: 2, name: "Other org")
      user = create(:user, role: "admin", organization: my_org)
      measurement = FactoryBot.create(:measurement, organization: other_org)

      sign_in user

      get edit_measurement_path(measurement)

      expect(response).to have_http_status(302)
    end

    it 'should have response code 302 for non-admin user' do
      measurement_id = FactoryBot.create(:measurement).id
      user = create(:user, role: "user")
      sign_in user
      get edit_measurement_path(measurement_id)

      expect(response).to have_http_status(302)
    end
  end
end
