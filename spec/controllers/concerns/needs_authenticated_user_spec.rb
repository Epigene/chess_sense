# spring rspec spec/controllers/concerns/needs_authenticated_user_spec.rb
describe NeedsAuthenticatedUser, type: :controller do
  # 1. inlude the module in some base controller, application controller should work
  controller(ApplicationController) do
    include NeedsAuthenticatedUser
  end

  describe "#current_user" do
    let!(:user) { log_in_user }

    it "looks up and memoizes the user in session" do
      expect(controller.send(:current_user).id).to eq(user.id)
    end
  end

  describe "#verify_authenticated_user" do
    subject(:verifying) { controller.send(:verify_authenticated_user) }

    before { allow(controller).to receive(:redirect_to) }

    context "when there's a user in session" do
      before { log_in_user }

      it "does nothing" do
        expect(controller).to_not receive(:redirect_to)

        verifying
      end
    end

    context "when there's no user in session" do
      before { allow(controller).to receive(:redirect_to) }

      it "redirects to root" do
        expect(controller).to receive(:redirect_to).with("/")

        verifying
      end
    end
  end

end
