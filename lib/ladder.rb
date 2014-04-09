require "ladder/version"
require "ladder/elo"
require "ladder/model"
require "sinatra/base"

module Ladder
  class Server < Sinatra::Base
    set :root, APPLICATION_PATH
    set :sessions, true

    use OmniAuth::Strategies::Developer
    
    helpers do
      def current_user
        @current_user ||= Ladder::Model.get_player(session[:uid]) if session[:uid]
      end
    end

    get '/' do
      @ladder = Ladder::Model.generate_ladder

      if current_user
        @challenges = Ladder::Model.get_active_challenges( session[:uid] )
      end

      haml :index
    end

    get '/about' do
      haml :about
    end

    # render player page
    get '/player/:uid' do
      if current_user
        @challenges = Ladder::Model.get_active_challenges( session[:uid] )
      end
      @player = Ladder::Model.get_player( params[:uid] )
      @history = Ladder::Model.get_challenges( params[:uid] )
      @chart = Array.new
      @chart << ['Date', 'Rating']
      @history.each do |match|
        @chart << [match[:modified].to_s, (match[:defender_uid] == params[:uid] ? match[:defender_rating] : match[:challenger_rating])  ]
      end
      haml :player
    end

    # create a new challenge
    post '/challenge/:uid' do
      if session[:uid]
        Ladder::Model.create_challenge( 
          { 'challenger_uid' => session['uid'],
            'defender_uid' => params['uid'],
            'created' => Time.now,
            'modified' => Time.now } )
      else
        raise 401
      end
    end

    # resolve a challenge
    post '/challenge/resolve/:id' do
      Ladder::Model.update_challenge(params['id'], 
        { 'winner' => params['winner'],
          'active' => false,
          'modified' => Time.now })
      
      Ladder::ELO.change( params['id'] )
      Ladder::Model.calculate_ranks

      redirect "/player/#{session[:uid]}"
    end

    post '/auth/:name/callback' do
      auth = request.env["omniauth.auth"]
      user = Ladder::Model.get_player(auth['uid'])

      if user.nil?
        user = Ladder::Model.create_player({
          'uid'       => auth['uid'],
          'name'      => auth['info']['name'],
          'nickname'  => auth['info']['nickname'],
          'rating'    => Ladder.config['default_rating'],
          'k_factor'  => Ladder.config['starter_k_factor'],
          'created'   => Time.now,
          'modified'  => Time.now,
          'wins'      => 0,
          'losses'    => 0,
          'ties'      => 0 })
        Ladder::Model.calculate_ranks
      end
      session[:uid] = auth['uid']
      redirect '/'
    end

    get "/log_out" do
      session[:uid] = nil
      redirect '/'
    end

    error 400..510 do
      'No Good.'
    end
  end

  def self.config
    unless @config
      begin
        @config = YAML.load(File.open(SETTINGS_PATH))
      rescue Exception => e
        puts "Error loading settings: #{e.to_s}"
        exit 1
      end
    end
    @config
  end
end
