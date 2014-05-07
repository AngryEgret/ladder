module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:player]
      player = FactoryGirl.create(:player)
      player.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in player 
    end
  end
end
