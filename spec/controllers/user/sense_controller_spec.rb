# spring rspec spec/controllers/user/sense_controller_spec.rb
RSpec.describe User::SenseController, type: :controller do
  before { allow_render; log_in_user }

  describe "GET :show" do
    subject(:make_request) { get :show, params: params }

    describe "routing" do
      it 'routes GET /user/sense' do
        expect(get: '/user/sense').to route_to(
          controller: 'user/sense',
          action: 'show',
        )
      end
    end

    let(:params) { {} }

    context "when requested" do
      it "renders the show template" do
        expect(controller).to receive(:render).with(
          template: "user/sense/show"
        ).once

        make_request
      end
    end
  end
end
