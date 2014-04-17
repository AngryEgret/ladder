json.array!(@matches) do |match|
  json.extract! match, :id, :rating, :result, :opponent_id, :player_id
  json.url match_url(match, format: :json)
end
