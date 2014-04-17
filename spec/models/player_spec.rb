require 'spec_helper'

describe Player do
  it { should respond_to(:name        ) }
  it { should respond_to(:twitter_id  ) }
  it { should respond_to(:wins        ) }
  it { should respond_to(:losses      ) }
  it { should respond_to(:ties        ) }

  let(:player) { FactoryGirl.create(:player) }

  describe 'has_many associations' do
    specify { player.should respond_to(:games) }
    specify { player.should respond_to(:matches) }
  end
end
