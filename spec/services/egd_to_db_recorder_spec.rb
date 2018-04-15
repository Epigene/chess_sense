# spring rspec spec/services/egd_to_db_recorder_spec.rb
describe EgdToDbRecorder do
  include ChessHelpers

  describe "#call" do
    subject(:calling) { described_class.new(*args).call }

    let!(:user) { create(:user) }
    let(:args) { [pgn, user.id] }

    context "when initialized with an EGD of a simple game of two moves" do
      let(:pgn) { standart_pgn_upload }

      it "ensures needed DB records" do
        expect{ calling }.to(
          change{ Position.all.size }.by(3).
          and change{ Move.all.size }.by(2).
          and change{ PositionTransition.all.size }.by(2).
          and change{ GamePositionTransition.all.size }.by(2).
          and change{ ChessGame.all.size }.by(1).
          and change{ user.reload.chess_games.size }.by(1)
        )
      end
    end

    context "when initialized with a game won by black" do
      let(:pgn) { "1. e4 0-1" }

      it "marks black player as the winner" do
        expect{ calling }.to_not raise_error
      end
    end

    context "when initialized with a drawn game" do
      let(:pgn) { "1. e4 1/2-1/2" }

      it 'marks winner as "\ndraw"' do
        expect{ calling }.to(
          change{ ChessGame.where(winner: "\ndraw").size }.by(1)
        )
      end
    end

    context "when initialized with an undecided game" do
      let(:pgn) { "1. e4 *" }

      it "marks winner as '-'" do
        expect{ calling }.to(
          change{ ChessGame.where(winner: "-").size }.by(1)
        )
      end
    end
  end

end
