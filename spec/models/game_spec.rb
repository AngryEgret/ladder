require 'spec_helper'

describe Game do
  it { should respond_to(:name) }

  let(:game) { FactoryGirl.create(:game) }

  describe 'has_many players' do
    specify { game.should respond_to(:players) }
  end
end
