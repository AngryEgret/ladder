require 'spec_helper'

describe Match do
  it { should respond_to(:rating   ) }
  it { should respond_to(:result   ) }

  describe 'associations' do
    it { should respond_to(:opponent ) }
    it { should respond_to(:player   ) }
  end

  let(:match) { FactoryGirl.create(:match) }
end
