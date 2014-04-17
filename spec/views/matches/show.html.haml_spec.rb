require 'spec_helper'

describe "matches/show" do
  before(:each) do
    @match = assign(:match, stub_model(Match,
      :rating => 1,
      :result => "Result",
      :opponent_id => 2,
      :player_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Result/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
