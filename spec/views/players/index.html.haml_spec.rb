require 'spec_helper'

describe "players/index" do
  before(:each) do
    assign(:players, [
      stub_model(Player,
        :name => "Name",
        :twitter_id => "Twitter",
        :rating => 1,
        :wins => 2,
        :losses => 3,
        :ties => 4
      ),
      stub_model(Player,
        :name => "Name",
        :twitter_id => "Twitter",
        :rating => 1,
        :wins => 2,
        :losses => 3,
        :ties => 4
      )
    ])
  end

  it "renders a list of players" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
