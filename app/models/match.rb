class Match < ActiveRecord::Base
  has_one :opponent, class_name: "Match", foreign_key: :opponent_id
  belongs_to :match, class_name: "Match", foreign_key: :opponent_id
  belongs_to :player
end
