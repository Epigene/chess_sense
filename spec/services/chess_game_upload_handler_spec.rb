# spring rspec spec/services/chess_game_upload_handler_spec.rb
describe ChessGameUploadHandler do
  include ChessHelpers

  describe "validations" do
    context "pgn_lines_length" do
      context "when given an upload string that is longer than 20k symbols" do
        let(:handler) { described_class.new(pgn_lines: "1" * (6**6)) }

        it "adds a validation error" do
          expect{ handler.valid? }.to(
            change{ handler.errors.messages[:base].present? }.from(false).to(true)
          )
        end
      end

      context "when given an upload string within 20k symbols" do
        let(:handler) { described_class.new(pgn_lines: "1") }

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

    context "when given a valid PGN for two games" do
      let(:params) { {pgn_lines: valid_pgn_upload} }

      it "makes two ChessGame records and returns a hash signifying 2 successes" do
        expect{ game_uploading }.to(
          change{ ChessGame.all.size }.by(2)
        )

        expect(game_uploading).to eq({ok: 2})
      end
    end

    context "when given a PGN with with one valid game block and garbled rest" do
      let(:params) { {pgn_lines: mixed_pgn_upload} }

      it "makes one ChessGame record and returns a hash signifying the mixed outcome" do
        expect{ game_uploading }.to(
          change{ ChessGame.all.size }.by(2)
        )

        expect(game_uploading).to eq({
          ok: 1, bad: 1,
          errors: ["test error"]
        })
      end
    end
  end
end
