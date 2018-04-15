# spring rspec spec/services/sense_spec.rb
describe Sense do
  describe "#call" do
    subject(:calling) { described_class.new(**options).call }

    context "when initialized with a :size query" do

      it { is_expected.to eq({size: 1}) }
    end

    context "when initialized with a :results query" do
      before do
        # There's 6 games in total
        # Epigene-Rufus 1-0
        # Rufus-Epigene 1-0
        # Epigene-Rufus 0-1
        # Rufus-Epigene 1/2-1/2
        # Epigene-Dufus 0-1
        # Rufus-Dufus 0-1
      end

      context "when looking from Epigene's perspective" do
        # let(:) {}

        it { is_expected.to eq({win: 1, draw: 1, loss: 3}) }
      end

      context "when looking from Rufus' perspective" do
        # let(:) {}

        it { is_expected.to eq({win: 2, draw: 1, loss: 2}) }
      end

      context "when looking from Dufus' perspective" do
        # let(:) {}

        it { is_expected.to eq({win: 2, draw: 0, loss: 0}) }
      end
    end

    context "when initialized with an :openings query" do

      it { is_expected.to eq({:"A01" => 1, :"A10" => 2}) }
    end

    context "when initialized with a :queen_captures query" do
      # A queen trade in this context is one where a queen capture by one side
      # is followed by a recapture within 5 moves

      it {
        is_expected.to eq({
          initialized: 1, took_back: 2, outright_capture: 1,
          outright_blunder: 1, no_queen_capturing: 1
        })
      }
    end

    context "when initialized with a :positions query" do
      # position histogram ignores positions that occur once

      context "when looking after 10th move" do
        # let(:) {}

        it { is_expected.to eq({:"SOME_FEN1" => 3, :"SOME_FEN2" => 2}) }
      end

      context "when looking after 11th move" do
        # let(:) {}

        it { is_expected.to eq({:"SOME_FEN1" => 2}) }
      end
    end

    context "when initialized with a :captures query" do
      it {
        is_expected.to eq({
          player: {
            :"pawn-pawn" => 0,
            :"pawn-knight" => 0,
            :"pawn-bishop" => 0,
            :"pawn-light_bishop" => 0,
            :"pawn-dark_bishop" => 0,
            :"pawn-rook" => 0,
            :"pawn-queen" => 0,
            :"knight-pawn" => 0,
            :"knight-knight" => 0,
            :"knight-bishop" => 0,
            :"knight-light_bishop" => 0,
            :"knight-dark_bishop" => 0,
            :"knight-rook" => 0,
            :"knight-queen" => 0,
            :"bishop-pawn" => 0,
            :"bishop-knight" => 0,
            :"bishop-bishop" => 0,
            :"bishop-light_bishop" => 0,
            :"bishop-dark_bishop" => 0,
            :"bishop-rook" => 0,
            :"bishop-queen" => 0,
            :"light_bishop-pawn" => 0,
            :"light_bishop-knight" => 0,
            :"light_bishop-bishop" => 0,
            :"light_bishop-light_bishop" => 0,
            :"light_bishop-dark_bishop" => 0,
            :"light_bishop-rook" => 0,
            :"light_bishop-queen" => 0,
            :"dark_bishop-pawn" => 0,
            :"dark_bishop-knight" => 0,
            :"dark_bishop-bishop" => 0,
            :"dark_bishop-light_bishop" => 0,
            :"dark_bishop-dark_bishop" => 0,
            :"dark_bishop-rook" => 0,
            :"dark_bishop-queen" => 0,
            :"rook-pawn" => 0,
            :"rook-knight" => 0,
            :"rook-bishop" => 0,
            :"rook-light_bishop" => 0,
            :"rook-dark_bishop" => 0,
            :"rook-rook" => 0,
            :"rook-queen" => 0,
            :"queen-pawn" => 0,
            :"queen-knight" => 0,
            :"queen-bishop" => 0,
            :"queen-light_bishop" => 0,
            :"queen-dark_bishop" => 0,
            :"queen-rook" => 0,
            :"queen-queen" => 0

          },
          opponent: {
            :"pawn-pawn" => 0,
            :"pawn-knight" => 0,
            :"pawn-bishop" => 0,
            :"pawn-light_bishop" => 0,
            :"pawn-dark_bishop" => 0,
            :"pawn-rook" => 0,
            :"pawn-queen" => 0,
            :"knight-pawn" => 0,
            :"knight-knight" => 0,
            :"knight-bishop" => 0,
            :"knight-light_bishop" => 0,
            :"knight-dark_bishop" => 0,
            :"knight-rook" => 0,
            :"knight-queen" => 0,
            :"bishop-pawn" => 0,
            :"bishop-knight" => 0,
            :"bishop-bishop" => 0,
            :"bishop-light_bishop" => 0,
            :"bishop-dark_bishop" => 0,
            :"bishop-rook" => 0,
            :"bishop-queen" => 0,
            :"light_bishop-pawn" => 0,
            :"light_bishop-knight" => 0,
            :"light_bishop-bishop" => 0,
            :"light_bishop-light_bishop" => 0,
            :"light_bishop-dark_bishop" => 0,
            :"light_bishop-rook" => 0,
            :"light_bishop-queen" => 0,
            :"dark_bishop-pawn" => 0,
            :"dark_bishop-knight" => 0,
            :"dark_bishop-bishop" => 0,
            :"dark_bishop-light_bishop" => 0,
            :"dark_bishop-dark_bishop" => 0,
            :"dark_bishop-rook" => 0,
            :"dark_bishop-queen" => 0,
            :"rook-pawn" => 0,
            :"rook-knight" => 0,
            :"rook-bishop" => 0,
            :"rook-light_bishop" => 0,
            :"rook-dark_bishop" => 0,
            :"rook-rook" => 0,
            :"rook-queen" => 0,
            :"queen-pawn" => 0,
            :"queen-knight" => 0,
            :"queen-bishop" => 0,
            :"queen-light_bishop" => 0,
            :"queen-dark_bishop" => 0,
            :"queen-rook" => 0,
            :"queen-queen" => 0
          }
        })
      }
    end

  end
end
