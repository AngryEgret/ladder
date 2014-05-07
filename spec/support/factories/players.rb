FactoryGirl.define do
  factory :player do
    name      'regret'
    email     'regret@email.com'
    password  'very_secret'
  end

  factory :player_with_games,  parent: :player do
    games {[
      FactoryGirl.create(:game, name: 'Street Fighter'),
      FactoryGirl.create(:game, name: 'King of Fighters')
    ]}
  end
  
  factory :player_with_games_and_matches,  parent: :player_with_games do
    matches {[
      FactoryGirl.create(:match)
    ]}
  end
end
