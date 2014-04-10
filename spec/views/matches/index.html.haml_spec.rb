require 'spec_helper'

describe "matches/index" do
  before(:each) do
    assign(:matches, [
      stub_model(Match,
        :challenger_id => "",
        :defender_id => "",
        :challenger_rating => "",
        :defender_rating => "",
        :winner_id => ""
      ),
      stub_model(Match,
        :challenger_id => "",
        :defender_id => "",
        :challenger_rating => "",
        :defender_rating => "",
        :winner_id => ""
      )
    ])
  end

  it "renders a list of matches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
