require 'spec_helper'

describe "matches/edit" do
  before(:each) do
    @match = assign(:match, stub_model(Match,
      :rating => 1,
      :result => "MyString",
      :opponent_id => 1,
      :player_id => 1
    ))
  end

  it "renders the edit match form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", match_path(@match), "post" do
      assert_select "input#match_rating[name=?]", "match[rating]"
      assert_select "input#match_result[name=?]", "match[result]"
      assert_select "input#match_opponent_id[name=?]", "match[opponent_id]"
      assert_select "input#match_player_id[name=?]", "match[player_id]"
    end
  end
end
