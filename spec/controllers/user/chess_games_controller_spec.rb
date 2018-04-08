# spring rspec spec/controllers/user/chess_games_controller_spec.rb
RSpec.describe User::ChessGamesController, type: :controller do
  include ChessHelpers

  before { allow_render; log_in_user }

  describe "GET :index" do
    subject(:make_request) { get :index }

    describe "routing" do
      it 'routes GET /user/chess_games' do
        expect(get: '/user/chess_games').to route_to(
          controller: 'user/chess_games',
          action: 'index',
        )
      end
    end

    it "renders the game index view" do
      expect(controller).to(
        receive(:render).with(
          template: "user/chess_games/index",
          locals: anything
        ).once
      )

      make_request
    end
  end

  describe "GET :new" do
    subject(:make_request) { get :new }

    describe "routing" do
      it 'routes GET /user/chess_games/new' do
        expect(get: '/user/chess_games/new').to route_to(
          controller: 'user/chess_games',
          action: 'new',
        )
      end
    end

    it "renders the game upload form view" do
      allow(controller).to(
        receive(:render).with(
          template: "user/chess_games/new"
        ).once
      )

      make_request
    end
  end

  describe "POST :create" do
    subject(:make_request) { post :create, params: params }

    describe "routing" do
      it 'routes POST /user/chess_games' do
        expect(post: '/user/chess_games').to route_to(
          controller: 'user/chess_games',
          action: 'create',
        )
      end
    end

    context "when requested with invalid params" do
      let(:params) { {chess_game_upload_handler: {pgn_lines: ""}} }

      let(:uploader) do
        ChessGameUploadHandler.new(pgn_lines: "", user_id: 1)
      end

      before do
        allow(ChessGameUploadHandler).to(
          receive(:new).and_return(uploader)
        )
      end

      it "renders upload form again with :danger flash about fail" do
        expect(controller).to(
          receive(:render).with(
            template: "user/chess_games/new",
            locals: {uploader: anything}
            ).once
        )

        make_request

        expect(flash[:danger]).to be_present
      end
    end

    context "when requested with valid submit params" do
      let(:uploader) do
        instance_double(
          ChessGameUploadHandler, valid?: true, call: result
        )
      end

      before do
        allow(ChessGameUploadHandler).to(
          receive(:new).and_return(uploader)
        )
      end

      context "when submitted upload results in only uploaded games" do
        let(:params) { {chess_game_upload_handler: {pgn_lines: valid_pgn_upload}} }
        let(:result) { {ok: 1, bad: 0, errors: []} }

        it "calls upload handler and redirects to game index with :success flash" do
          expect(uploader).to receive(:call)

          make_request

          expect(response.location).to match(%r'/user/chess_games')

          expect(flash[:success]).to be_present
        end
      end

      context "when submitted upload results in at least one error" do
        let(:params) { {chess_game_upload_handler: {pgn_lines: partially_valid_pgn_upload}} }
        let(:result) { {ok: 0, bad: 1, errors: ["test error"]} }

        it "calls upload handler and redirects to game index with :danger flash" do
          expect(uploader).to receive(:call)

          make_request

          expect(response.location).to match(%r'/user/chess_games')

          expect(flash[:danger]).to be_present
        end
      end
    end
  end

  describe "GET :show" do
    subject(:make_request) { get :show, params: params }

    describe "routing" do
      it 'routes GET /user/chess_games/:id' do
        expect(get: '/user/chess_games/1').to route_to(
          controller: 'user/chess_games',
          action: 'show',
          id: '1'
        )
      end
    end

    let!(:user) { log_in_user }
    let!(:owned_game) { create(:chess_game, user: user) }

    before { allow_render }

    context "when requested with an id of a game the user has access to" do
      let(:params) { {id: owned_game.id} }

      it "renders the game view" do
        expect(controller).to(
          receive(:render).with(
            template: "user/chess_games/show",
            locals: {game: owned_game}
          ).once
        )

        make_request
      end
    end

    context "when requested with an id of a game the user does not have access to" do
      let(:params) { {id: unowned_game.id} }

      let!(:unowned_game) { create(:chess_game) }

      it "redirects to game index with an alert flash" do
        make_request

        expect(response.location).to match(%r'')

        expect(flash[:danger]).to be_present
      end
    end
  end
end
