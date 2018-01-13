# spring rspec spec/models/chess_game_spec.rb
RSpec.describe ChessGame, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"


  describe "Scopes" do
    describe ".with_queen_trade" do
      subject(:records) { described_class.with_queen_trade }

      it "collects games that have queens dropping off within 3 moves of each other" do
        expect(records.pluck(:id)).to(
          eq(1)
        )
      end
    end

    describe ".with_first_capture(options)" do
      subject(:records) { described_class.with_first_capture(options) }

      before(:all) do
        set_up_the_8_games
        # There are 4 dimensions:
        #  1) Player
        #  2) Captured piece
        #  3) Order of capture (only first occurance matches)
        #  4) capturing piece
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA", using: "N"} }

        it "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA"} }

        it "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of piece only" do
        let(:options) { {of: "Q", by: "playerA"} }

        it "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end
    end

    describe ".with_a_capture(options)" do
      subject(:records) { described_class.with_a_capture(options) }

      before(:all) do
        set_up_the_8_games
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA", using: "N"} }

        it "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA"} }

        it "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end
    end

    describe ".where_a_queen_trade_initiated_by(player_identifier)" do
      subject(:records) { where_a_queen_trade_initiated_by(player_identifier) }

      it "collects games where given player initiated a queen trade" do
        expect(0).to(
          eq(1)
        )
      end
    end

  end
end
