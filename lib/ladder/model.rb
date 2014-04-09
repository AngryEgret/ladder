require "sequel"
require "omniauth"
require "omniauth-twitter"

module Ladder
  module Model
    def self.connection
      @connection ||= @connection = Sequel.sqlite('/tmp/ladder.db')
    end

    def self.generate_ladder
      db = connection
      ladder = db[:players].select(:uid, :name, :rating, :rank, :wins, :losses, :ties).order(Sequel.desc(:rating),Sequel.desc(:modified)).all
    end

    def self.create_player( params )
      db = connection
      db[:players].insert( params.symbolize_keys! )
    end

    def self.get_player( player_uid )
      db = connection
      player = db[:players].where( :uid => player_uid ).first
    end

    def self.update_player( uid, params )
      db = connection
      puts uid
      puts params.symbolize_keys!.inspect
      db[:players].where( :uid => uid ).update(params.symbolize_keys!)
    end

    def self.create_challenge( params )
      db = connection
      challenge = db[:challenges].insert( params.symbolize_keys! )
    end

    def self.get_challenge( challenge_id )
      db = connection
      db[:challenges].where(:id => challenge_id).first
    end

    def self.get_active_challenges( user_id )
      db = connection
      db[:challenges].where{created < Time.now - Ladder.config['challenge_timeout'].to_i}.update(:active => false)
      db[:challenges].where(:challenger_uid => user_id).or(:defender_uid => user_id).where(:active => true)
    end

    def self.get_challenges( player_id )
      db = connection
      db[:challenges].where(:challenger_uid => player_id).or(:defender_uid => player_id).limit(Ladder.config['history_limit'])
    end

    def self.update_challenge( challenge_id, params )
      db = connection
      db[:challenges].where( :id => challenge_id ).update(params.symbolize_keys!)
    end

    def self.calculate_ranks
      db = connection
      ranks = db.fetch("select uid, (select count(*) from players as p2 where p2.rating > p1.rating) rank from players as p1;").all

      ranks.each do |rank|
        update_player( rank[:uid], { 'rank' => rank[:rank] + 1 })
      end
    end
  end
end

class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

Ladder::Model.connection.use_timestamp_timezones = false

begin
  Ladder::Model.connection.drop_table :players
rescue Exception => e
  e.to_s
end
Ladder::Model.connection.create_table :players do
  primary_key :id
  String      :uid
  String      :name
  String      :nickname
  Integer     :rating
  Integer     :rank
  Integer     :wins
  Integer     :losses
  Integer     :ties
  Integer     :k_factor
  DateTime    :created
  DateTime    :modified
end

begin
  Ladder::Model.connection.drop_table :challenges
rescue Exception => e
  e.to_s
end
Ladder::Model.connection.create_table :challenges do
  primary_key :id
  String      :challenger_uid
  String      :defender_uid
  String      :winner # nil is unresolved, 0 is tied, otherwise player_uid
  Integer     :challenger_rating # post resolution ratings
  Integer     :defender_rating
  TrueClass   :active, :default => true
  DateTime    :created
  DateTime    :modified
end
