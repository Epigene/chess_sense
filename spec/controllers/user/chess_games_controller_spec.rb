# spring rspec spec/controllers/user/chess_games_controller_spec.rb
RSpec.describe User::ChessGamesController, type: :controller do
  describe "routing" do
    it 'routes GET /user/chess_games' do
      expect(get: '/user/chess_games').to route_to(
        controller: 'user/chess_games',
        action: 'index',
      )
    end

    it 'routes GET /user/chess_games/:id' do
      expect(get: '/user/chess_games/1').to route_to(
        controller: 'user/chess_games',
        action: 'show',
        id: '1'
      )
    end
  end

  describe "GET :index" do
    subject(:make_request) { get :index }

    before { allow_render; log_in_user }

    it "renders the game index view" do
      expect(controller).to(
        receive(:render).with(template: "user/chess_games/index").once
      )

      make_request
    end
  end

  describe "GET :show" do
    subject(:make_request) { get :show, params: params }

    let!(:user) { log_in_user }
    let!(:owned_game) { create(:chess_game, user: user) }

    before { allow_render }

    context "when requested with an id of a game the user has access to" do
      let(:params) { {id: owned_game.id} }

      it "renders the game view" do
        expect(controller).to(
          receive(:render).with(template: "user/chess_games/show").once
        )

        make_request
      end
    end

    context "when requested with an id of a game the user does not have access to" do
      let(:params) { {id: unowned_game.id} }

      let!(:unowned_game) { create(:chess_game) }

      xit "redirects to game index with an alert flash" do
        expect(0).to(
          eq(1)
        )
      end
    end
  end
end
