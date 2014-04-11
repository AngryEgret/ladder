require 'spec_helper'

describe Game do
  it 'has many matches' do
    game = Game.create
    3.times { game.matches.create }

    expect(game.matches.count).to eq 3
  end
end
