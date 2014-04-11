class Match < ActiveRecord::Base
  belongs_to :challenger, class_name: "Player", foreign_key: "challenger_id"
  belongs_to :defender,   class_name: "Player", foreign_key: "defender_id"
  belongs_to :game
end
