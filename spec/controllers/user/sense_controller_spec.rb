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

    context "when requested with minimum params" do
      let(:params) { super().merge(tell_me: ["size"].to_json) }

      xit "renders the show template" do
        expect(controller).to receive(:render).with(
          template: "user/sense/show",
          locals: {sense_data: anything}
        ).once

        make_request
      end
    end

    context "when requested without even minimum params" do
      it "applies default params and redirects to self" do
        make_request

        expect(response.location).to match(
          %r'/user/sense\?tell_me=size'i
        )
      end
    end

  end
end
