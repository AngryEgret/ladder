require 'spec_helper'

describe Match do
  it 'correctly associates the challenger' do
    player_one = Player.create(name:'player1')
    match = player_one.matches.create

    expect(match.challenger_id).to eq player_one.id
    expect(match.defender_id).to eq nil
  end

  it 'correctly associates the defender' do
    player_one = Player.create(name:'player1')
    player_two = Player.create(name:'player2')

    match = player_one.matches.create

    match.defender = player_two

    match2 = player_two

    expect(match.challenger_id).to eq player_one.id
    expect(match.defender_id).to eq player_two.id
  end
end
