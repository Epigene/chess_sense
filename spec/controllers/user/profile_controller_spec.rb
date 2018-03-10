# spring rspec spec/controllers/user/profile_controller_spec.rb
RSpec.describe User::ProfileController, type: :controller do
  let!(:user) { create(:user) }
  before { allow_render; log_in_user(user) }

  describe "GET :show" do
    subject(:make_request) { get :show }

    describe "routing" do
      it 'routes GET /user/profile' do
        expect(get: '/user/profile').to route_to(
          controller: 'user/profile',
          action: 'show',
        )
      end
    end

    it "renders the profile view" do
      expect(controller).to(
        receive(:render).with(template: "user/profile/show").once
      )

      make_request
    end
  end

  describe "PATCH :update" do
    subject(:make_request) { patch :update, params: params }

    describe "routing" do
      it 'routes PATCH /user/profile' do
        expect(patch: '/user/profile').to route_to(
          controller: 'user/profile',
          action: 'update',
        )
      end
    end

    let(:params) do
      {
        user: {
          email: "ignored", # counter
          name: "Bob",
          chess_aliases: ["Bob", "Bobby"],
          password: "super",
          password_confirmation: "super"
        }
      }
    end

    context "when requested with legit update params" do
      it "updates the user and redirects to :show with :notice flash" do
        expect{ make_request }.to(
          change{ user.reload.name }.to("Bob").
          and change{ user.reload.chess_aliases }.to(["Bob", "Bobby"]).
          and change{ user.reload.password_digest }.
          and not_change{ user.reload.email }
        )

        expect(response.location).to match(%r'/user/profile\z')

        expect(flash[:notice]).to be_present
      end
    end

    context "when update does not succeed" do
      let(:params) { super().deep_merge({user: {password_confirmation: "a"}}) }

      it "does not update the user, renders :show with an :alert flash" do
        expect(controller).to receive(:render).with(
          template: "user/profile/show"
        ).once

        expect{ make_request }.to_not change{ user.reload }

        expect(flash[:alert]).to be_present
      end
    end
  end
end
