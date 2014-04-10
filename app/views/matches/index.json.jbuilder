json.array!(@matches) do |match|
  json.extract! match, :id, :challenger_id, :defender_id, :challenger_rating, :defender_rating, :winner_id
  json.url match_url(match, format: :json)
end
