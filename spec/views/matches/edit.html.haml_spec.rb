require 'spec_helper'

describe "matches/edit" do
  before(:each) do
    @match = assign(:match, stub_model(Match,
      :challenger_id => 1,
      :defender_id => 1,
      :challenger_rating => 1,
      :defender_rating => 1,
      :winner_id => 1
    ))
  end

  it "renders the edit match form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", match_path(@match), "post" do
      assert_select "input#match_challenger_id[name=?]", "match[challenger_id]"
      assert_select "input#match_defender_id[name=?]", "match[defender_id]"
      assert_select "input#match_challenger_rating[name=?]", "match[challenger_rating]"
      assert_select "input#match_defender_rating[name=?]", "match[defender_rating]"
      assert_select "input#match_winner_id[name=?]", "match[winner_id]"
    end
  end
end
