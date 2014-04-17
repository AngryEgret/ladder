json.array!(@players) do |player|
  json.extract! player, :id, :name, :twitter_id, :wins, :losses, :ties
  json.url player_url(player, format: :json)
end
