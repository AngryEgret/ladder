module Elo
  def k_factor
    
  end

  def calculate
    #( k_factor.to_f * ( result.to_f - expected( c_rating, d_rating ) ) ).round
    ( k_factor * ( result - expected( c_rating, d_rating ) ) ).round
  end
end

