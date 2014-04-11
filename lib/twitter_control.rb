require 'twitter'

class TwitterControl
  def notify(challenger, defender)
    Twitter.direct_message_create(defender, "#{challenger} has challenged you!")
    Twitter.direct_message_create(challenger, "You have challenged #{defender}.")
  end

  def post_match(winner, loser)
        
  end
end

