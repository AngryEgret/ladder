require 'spec_helper'

describe "matches/index" do
  before(:each) do
    assign(:matches, [
      stub_model(Match,
        :challenger_id => 1,
        :defender_id => 2,
        :challenger_rating => 3,
        :defender_rating => 4,
        :winner_id => 5
      ),
      stub_model(Match,
        :challenger_id => 1,
        :defender_id => 2,
        :challenger_rating => 3,
        :defender_rating => 4,
        :winner_id => 5
      )
    ])
  end

  it "renders a list of matches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
