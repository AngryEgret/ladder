FactoryGirl.define do
  factory :game do
    name      'Street Fighter 4'
    players   {[]}
  end

  factory :game_with_players, parent: :game do
    players {[
      FactoryGirl.create(:player, name: 'regret'),
      FactoryGirl.create(:player, name: 'jway'),
      FactoryGirl.create(:player, name: 'racevedo')
    ]}
  end
end
