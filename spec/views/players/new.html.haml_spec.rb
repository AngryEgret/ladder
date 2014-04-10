require 'spec_helper'

describe "players/new" do
  before(:each) do
    assign(:player, stub_model(Player,
      :name => "MyString",
      :twitter_id => "MyString",
      :rating => 1,
      :wins => 1,
      :losses => 1,
      :ties => 1
    ).as_new_record)
  end

  it "renders new player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", players_path, "post" do
      assert_select "input#player_name[name=?]", "player[name]"
      assert_select "input#player_twitter_id[name=?]", "player[twitter_id]"
      assert_select "input#player_rating[name=?]", "player[rating]"
      assert_select "input#player_wins[name=?]", "player[wins]"
      assert_select "input#player_losses[name=?]", "player[losses]"
      assert_select "input#player_ties[name=?]", "player[ties]"
    end
  end
end
