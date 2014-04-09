module Ladder
  module ELO
    def self.expected( old_rating, opponent_rating )
      1.0 / ( 1.0 + ( 10.0 ** ((opponent_rating.to_f - old_rating.to_f) / 400.0) ) )
    end

    def self.calc_change( k_factor, result, c_rating, d_rating )
      ( k_factor.to_f * ( result.to_f - expected( c_rating, d_rating ) ) ).round
    end

    def self.change( challenge_id )
      challenge = Ladder::Model.get_challenge challenge_id

      challenger = Ladder::Model.get_player( challenge[:challenger_uid] )
      defender = Ladder::Model.get_player( challenge[:defender_uid] )

      change = { challenger[:uid] => { 'win'  => challenger[:rating] + calc_change( challenger[:k_factor],
                                      1.0,
                                      challenger[:rating],
                                      defender[:rating] ),
                                    'loss' => challenger[:rating] + calc_change( challenger[:k_factor],
                                      0.0,
                                      challenger[:rating],
                                      defender[:rating] ),
                                    'draw' => challenger[:rating] + calc_change( challenger[:k_factor],
                                      0.5,
                                      challenger[:rating],
                                      defender[:rating] ) },
               defender[:uid] => { 'win'  => defender[:rating] + calc_change( defender[:k_factor],
                                    1.0,
                                    defender[:rating],
                                    challenger[:rating] ),
                                  'loss' => defender[:rating] + calc_change( defender[:k_factor],
                                    0.0,
                                    defender[:rating],
                                    challenger[:rating] ),
                                  'draw' => defender[:rating] + calc_change( defender[:k_factor],
                                    0.5,
                                    defender[:rating],
                                    challenger[:rating] ) } }

      case challenge[:winner]
      when '0'
        Ladder::Model.update_player( challenger[:uid], 
          { 'rating' => change[challenger[:uid]]['draw'],
            'ties'   => challenger[:ties] + 1 } )
        Ladder::Model.update_player( defender[:uid], 
          { 'rating' => change[defender[:uid]]['draw'],
            'ties'   => defender[:ties] + 1 } )
        Ladder::Model.update_challenge( challenge_id,
            'challenger_rating' => change[challenger[:uid]]['draw'],
            'defender_rating'   => change[defender[:uid]]['draw'] )
      when challenger[:uid]
        Ladder::Model.update_player( challenger[:uid], 
          { 'rating' => change[challenger[:uid]]['win'],
            'wins'   => challenger[:wins] + 1 } )
        Ladder::Model.update_player( defender[:uid], 
          { 'rating' => change[defender[:uid]]['loss'],
            'losses'   => defender[:losses] + 1 } )
        Ladder::Model.update_challenge( challenge_id,
            'challenger_rating' => change[challenger[:uid]]['win'],
            'defender_rating'   => change[defender[:uid]]['loss'] )
      when defender[:uid]
        Ladder::Model.update_player( challenger[:uid], 
          { 'rating' => change[challenger[:uid]]['loss'],
            'losses'   => challenger[:losses] + 1 } )
        Ladder::Model.update_player( defender[:uid], 
          { 'rating' => change[defender[:uid]]['win'],
            'wins'   => defender[:wins] + 1 } )
        Ladder::Model.update_challenge( challenge_id,
            'challenger_rating' => change[challenger[:uid]]['loss'],
            'defender_rating'   => change[defender[:uid]]['win'] )
      end
    end
  end
end
