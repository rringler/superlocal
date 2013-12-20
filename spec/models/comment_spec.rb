require 'spec_helper'

describe Comment do
  it 'has valid factories' do
    FactoryGirl.create(:comment).should be_valid
  end

  describe 'validations' do
    describe 'text' do
      it 'is present' do
        FactoryGirl.build(:comment, text: nil).should_not be_valid
      end
    end
  end
end
