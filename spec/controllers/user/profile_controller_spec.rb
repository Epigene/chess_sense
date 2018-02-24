# spring rspec spec/controllers/user/profile_controller_spec.rb
RSpec.describe User::ProfileController, type: :controller do
  describe "routing" do
    it 'routes GET /user/profile' do
      expect(get: '/user/profile').to route_to(
        controller: 'user/profile',
        action: 'show',
      )
    end

    it 'routes PATCH /user/profile' do
      expect(patch: '/user/profile').to route_to(
        controller: 'user/profile',
        action: 'update',
      )
    end
  end

  describe "GET :show" do
    subject(:make_request) { get :show }

    before { allow_render }

    it "renders the profile view" do
      expect(controller).to(
        receive(:render).with(template: "user/profile/show").once
      )

      make_request
    end
  end

  describe "PATCH :update" do
    subject(:make_request) { patch :update, params: params }

    context "when requested with legit update params" do
      xit "updates the user and redirects to profile show" do
        expect(0).to(
          eq(1)
        )
      end
    end

    context "when requested with shady update params" do
      before { allow_render }

      xit "does not update the user, renders" do
        expect(0).to(
          eq(1)
        )
      end
    end
  end
end
