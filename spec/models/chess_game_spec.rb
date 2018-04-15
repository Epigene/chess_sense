# spring rspec spec/models/chess_game_spec.rb
RSpec.describe ChessGame, type: :model do
  describe "Scopes" do
    describe ".played_by(*p)" do
      subject(:collection) { described_class.played_by(*players).pluck(:id) }

      let(:players) { ["epigene"] }

      let!(:epigene_rufus) { create(:chess_game, white: "epigene", black: "rufus") }
      let!(:rufus_epigene) { create(:chess_game, white: "rufus", black: "epigene") }
      let!(:rufus_dufus) { create(:chess_game, white: "rufus", black: "dufus") } # counter

      it { is_expected.to contain_exactly(epigene_rufus.id, rufus_epigene.id) }
    end

    describe ".with_winner(*w)" do
      subject(:collection) { described_class.with_winner(*options).pluck(:id) }

      let!(:epigene_Rufus_u) { create(:chess_game, white: "epigene", black: "Rufus", result: "*") }
      let!(:epigene_rufus_1_0) { create(:chess_game, white: "epigene", black: "rufus", result: "1-0") }
      let!(:epigene_rufus_0_1) { create(:chess_game, white: "epigene", black: "rufus", result: "0-1") }

      context "when queried with a winner in mind" do
        let(:options) { ["rufus"] }

        it { is_expected.to contain_exactly(epigene_rufus_0_1.id) }
      end

      context "when queried without a winner arg" do
        let(:options) { [nil] }

        it { is_expected.to contain_exactly(epigene_rufus_1_0.id, epigene_rufus_0_1.id) }
      end
    end

    describe ".without_winner(*w)" do
      subject(:collection) { described_class.without_winner(*options).pluck(:id) }

      let!(:epigene_Rufus_u) { create(:chess_game, white: "epigene", black: "Rufus", result: "*") }
      let!(:epigene_rufus_1_0) { create(:chess_game, white: "epigene", black: "rufus", result: "1-0") }
      let!(:epigene_rufus_0_1) { create(:chess_game, white: "epigene", black: "rufus", result: "0-1") }

      context "when queried with a winner in mind" do
        let(:options) { ["rufus"] }

        it { is_expected.to contain_exactly(epigene_Rufus_u.id, epigene_rufus_1_0.id) }
      end

      context "when queried with a winner 2 in mind" do
        let(:options) { ["epigene"] }

        it { is_expected.to contain_exactly(epigene_Rufus_u.id, epigene_rufus_0_1.id) }
      end

      context "when queried without a winner arg" do
        let(:options) { [nil] }

        it { is_expected.to contain_exactly(epigene_Rufus_u.id) }
      end
    end

    describe ".with_loser(*l)" do
      subject(:collection) { described_class.with_loser(*options).pluck(:id) }

      let!(:epigene_Rufus_u) { create(:chess_game, white: "epigene", black: "Rufus", result: "*") }
      let!(:epigene_rufus_1_0) { create(:chess_game, white: "epigene", black: "rufus", result: "1-0") }
      let!(:epigene_rufus_0_1) { create(:chess_game, white: "epigene", black: "rufus", result: "0-1") }

      context "when called with an explicit loser in mind" do
        let(:options) { ["rufus"] }

        it { is_expected.to contain_exactly(epigene_rufus_1_0.id) }
      end

      context "when called without an explicit loser" do
        let(:options) { [nil] }

        it { is_expected.to contain_exactly(epigene_rufus_1_0.id, epigene_rufus_0_1.id) }
      end
    end

    describe ".decided" do
      let!(:draw) { create(:chess_game, :draw) }
      let!(:decided) { create(:chess_game, :decided) }

      it "collects games with a winner and a loser" do
        expect(described_class.decided).to contain_exactly(decided)
      end
    end

    describe ".draw" do
      let!(:draw) { create(:chess_game, :draw) }
      let!(:undecided) { create(:chess_game, :undecided) }

      it "collects drawn games" do
        expect(described_class.draw).to contain_exactly(draw)
      end
    end

    describe ".undecided" do
      let!(:draw) { create(:chess_game, :draw) }
      let!(:undecided) { create(:chess_game, :undecided) }

      it "collects undecided games" do
        expect(described_class.undecided).to contain_exactly(undecided)
      end
    end

    describe ".of_outcome(outcome:, for_player:)" do
      subject(:collection) { described_class.of_outcome(**options).pluck(:id) }

      let(:options) { {o: outcome, for_player: player} }

      before(:all) do
        @epigene_Rufus_1_0 = create(:chess_game, white: "epigene", black: "Rufus", result: "1-0")
        @Rufus_Epigene_0_1 = create(:chess_game, white: "Rufus", black: "Epigene", result: "0-1")

        @Rufus_Epigene_1_0 = create(:chess_game, white: "Rufus", black: "Epigene", result: "1-0")

        @Rufus_Epigene_d = create(:chess_game, white: "Rufus", black: "Epigene", result: "1/2-1/2")

        @Rufus_Epigene_u = create(:chess_game, white: "Rufus", black: "Epigene", result: "*")
      end

      after(:all) { clear_db! }

      context "when queried from Epigene's perspective" do
        let(:player) { "Epigene" }

        context "when queried for 'win' outcomes" do
          let(:outcome) { "win" }

          it { is_expected.to contain_exactly(@Rufus_Epigene_0_1.id) }
        end

        context "when queried for 'loss' outcomes" do
          let(:outcome) { "loss" }

          it { is_expected.to contain_exactly(@Rufus_Epigene_1_0.id) }
        end

        context "when queried for 'draw' outcomes" do
          let(:outcome) { "draw" }

          it { is_expected.to contain_exactly(@Rufus_Epigene_d.id) }
        end

        context "when queried for 'undecided' outcomes" do
          let(:outcome) { "undecided" }

          it { is_expected.to contain_exactly(@Rufus_Epigene_u.id) }
        end

        context 'when queried for ["draw", "undecided"] outcomes' do
          let(:outcome) { ["draw", "undecided"] }

          # TODO, support several outcome combo query
          xit { is_expected.to contain_exactly(@Rufus_Epigene_d.id, @Rufus_Epigene_u.id) }
        end
      end

      context "when queried from array [Epigene, epigene]'s perspective" do
        let(:player) { ["Epigene", "epigene"] }

        context "when queried for 'win' outcomes" do
          let(:outcome) { "win" }

          it { is_expected.to contain_exactly(@epigene_Rufus_1_0.id, @Rufus_Epigene_0_1.id) }
        end
      end
    end

    describe ".with_queen_trade" do
      subject(:records) { described_class.with_queen_trade }

      xit "collects games that have queens dropping off within 3 moves of each other" do
        expect(records.pluck(:id)).to(
          eq(1)
        )
      end
    end

    describe ".with_first_capture(options)" do
      subject(:records) { described_class.with_first_capture(options) }

      before(:all) do
        # set_up_the_8_games

        # There are 4 dimensions:
        #  1) Player
        #  2) Captured piece
        #  3) Order of capture (only first occurance matches)
        #  4) capturing piece
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA", using: "N"} }

        xit "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA"} }

        xit "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of piece only" do
        let(:options) { {of: "Q", by: "playerA"} }

        xit "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end
    end

    describe ".with_a_capture(options)" do
      subject(:records) { described_class.with_a_capture(options) }

      before(:all) do
        # set_up_the_8_games
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA", using: "N"} }

        xit "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end

      context "when options are about capture of Q by player" do
        let(:options) { {of: "Q", by: "playerA"} }

        xit "collects only games where specified player did the first capture" do
          expect(records.pluck(:id)).to(
            eq(1)
          )
        end
      end
    end

    describe ".where_a_queen_trade_initiated_by(player_identifier)" do
      subject(:records) { where_a_queen_trade_initiated_by(player_identifier) }

      xit "collects games where given player initiated a queen trade" do
        expect(0).to(
          eq(1)
        )
      end
    end

  end
end
