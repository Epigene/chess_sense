# spring rspec spec/services/chess_game_upload_handler_spec.rb
describe ChessGameUploadHandler do
  include ChessHelpers

  describe "validations" do
    context "pgn_lines_length" do
      context "when given an upload string that is too damn short" do
        let(:handler) { described_class.new(pgn_lines: "1.e", user_id: 1) }

        it "adds a validation error" do
          expect{ handler.valid? }.to(
            change{ handler.errors.messages[:base].present? }.from(false).to(true)
          )
        end
      end

      context "when given an upload string that is longer than 20k symbols" do
        let(:handler) { described_class.new(user_id: 1, pgn_lines: "1" * (6**6)) }

        it "adds a validation error" do
          expect{ handler.valid? }.to(
            change{ handler.errors.messages[:base].present? }.from(false).to(true)
          )
        end
      end

      context "when given an upload string within 20k symbols" do
        let(:handler) { described_class.new(user_id: 1, pgn_lines: "1.e4") }

        it "does not add error" do
          expect{ handler.valid? }.to(
            not_change{ handler.errors.messages[:base].present? }
          )
        end
      end
    end
  end

  describe "#call" do
    subject(:game_uploading) { described_class.new(params).call }

    let!(:user) { create(:user) }
    let(:params) { {pgn_lines: pgn, user_id: user.id} }

    context "when given a valid PGN for two games" do
      let(:pgn) { two_game_pgn_upload }

      it "makes two ChessGame records and returns a hash signifying 2 successes" do
        expect{ game_uploading }.to(
          change{ ChessGame.all.size }.by(2)
        )

        expect(game_uploading).to eq({ok: 2, bad: 0, errors: []})
      end
    end

    context "when given a PGN with one garbled game and two OKs" do
      let(:pgn) { mixed_pgn_upload }

      it "makes two ChessGame records and returns a hash signifying the mixed outcome" do
        expect{ game_uploading }.to(
          change{ ChessGame.all.size }.by(2)
        )

        expect(game_uploading).to match({
          ok: 2, bad: 1,
          errors: [anything]
        })
      end
    end

    context "when given a PGN without blank lines between games" do
      let(:pgn) { no_blank_lines_pgn_upload }

      it "makes two ChessGame records all the same" do
        expect{ game_uploading }.to(
          change{ ChessGame.all.size }.by(2)
        )
      end
    end
  end
end
