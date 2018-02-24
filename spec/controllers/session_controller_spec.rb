# spring rspec spec/controllers/session_controller_spec.rb
RSpec.describe SessionController, type: :controller do
  describe "routing" do
    it 'routes GET /' do
      expect(get: '/').to route_to(
        controller: 'session',
        action: 'new',
      )
    end

    it 'routes POST /login' do
      expect(post: '/login').to route_to(
        controller: 'session',
        action: 'create',
      )
    end

    it 'routes DELETE /logout' do
      expect(delete: '/logout').to route_to(
        controller: 'session',
        action: 'destroy',
      )
    end
  end

  describe "GET :new" do
    subject(:make_request) { get :new }

    before { allow_render }

    context "when requested without user in session" do
      it "renders the login form" do
        expect(controller).to receive(:render).with(
          template: "session/new",
          locals: {login: anything}
        ).once

        make_request
      end
    end

    context "when requested with user already in session" do
      before { log_in_user }

      it "redirects to sense view" do
        make_request

        expect(response.location).to match(%r'/user/sense')
      end
    end
  end

  describe "POST :create" do
    subject(:make_request) { post :create, params: params }

    context "when submitted a valid email and password combo" do
      let(:params) { {login: {email: user.email, password: "test_password"}} }
      let(:user) { create(:user) }

      it "stores user in session and redirects to sense view" do
        expect{ make_request }.to(
          change{ session[:user_id] }.from(nil).to(user.id)
        )

        expect(response.location).to match(%r'user/sense')
      end
    end

    context "when submitted an invalid email and password combo" do
      let(:params) { {login: {email: "", password: ""}} }

      before { allow_render }

      it "renders :new with a validation error" do
        expect(controller).to(
          receive(:render).with(template: "session/new", locals: anything).once
        )

        make_request
      end
    end
  end

  describe "DELETE :destroy" do
    subject(:make_request) { delete :destroy }

    let!(:user) { log_in_user }

    it "removes any :user_id from session, logging user out, redirects to root" do
      expect{ make_request }.to(
        change{ session[:user_id] }.from(user.id).to(nil)
      )

      expect(response.location).to eq("http://test.host/")
    end
  end
end
