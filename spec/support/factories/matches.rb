FactoryGirl.define do
  factory :pending_match do
    player    {FactoryGirl.create(:player, name: 'regret')}
    opponent  {FactoryGirl.create(:match)}
  end

  factory :complete_match, parent: :pending_match do
    rating    1500
    result    'win'
    opponent  {FactoryGirl.create(:match, rating: 1400, result: 'loss')}
  end
end
