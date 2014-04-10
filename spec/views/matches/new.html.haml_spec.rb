require 'spec_helper'

describe "matches/new" do
  before(:each) do
    assign(:match, stub_model(Match,
      :challenger_id => "",
      :defender_id => "",
      :challenger_rating => "",
      :defender_rating => "",
      :winner_id => ""
    ).as_new_record)
  end

  it "renders new match form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", matches_path, "post" do
      assert_select "input#match_challenger_id[name=?]", "match[challenger_id]"
      assert_select "input#match_defender_id[name=?]", "match[defender_id]"
      assert_select "input#match_challenger_rating[name=?]", "match[challenger_rating]"
      assert_select "input#match_defender_rating[name=?]", "match[defender_rating]"
      assert_select "input#match_winner_id[name=?]", "match[winner_id]"
    end
  end
end
