require 'spec_helper'

describe Player do
  it 'has many matches' do
    player = Player.create

    3.times { player.matches.create }

    expect(player.matches.count).to eq 3
  end
end
