class Player < ActiveRecord::Base
  has_many :matches, class_name: "Match", foreign_key: "challenger_id"
  has_many :defender_matches,   class_name: "Match", foreign_key: "defender_id"
end
