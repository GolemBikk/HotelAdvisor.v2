require 'rails_helper'

describe 'Patch requests', type: :request do
  describe ' PATCH /users/edit' do
    let(:user) { FactoryGirl.create(:user) }
    let(:new_user) {FactoryGirl.create(:user, first_name: 'Peter')}

    describe 'as unauthorized user' do
      describe 'submitting to the update action' do
        before do
          patch(id: user.id, user: user)
        end

        specify { expect(response).to redirect_to(new_user_session_path) }
      end
    end
  end
end