require 'spec_helper'

describe Comment do
  it 'should have valid factories' do
    FactoryGirl.create(:comment).should be_valid
  end

  describe 'validations' do
    describe 'text' do
      it 'should be present' do
        FactoryGirl.build(:comment, text: nil).should_not be_valid
      end
    end

    describe 'user_id' do
      it 'should be present' do
        FactoryGirl.build(:comment, user_id: nil).should_not be_valid
      end
    end

    describe 'post_id' do
      it 'should be present' do
        FactoryGirl.build(:comment, post_id: nil).should_not be_valid
      end
    end
  end

  it 'should be voteable by other users' do
    user = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:comment)

    expect { user.up_vote(comment) }.to change(comment, :plusminus).by(1)
  end

  it 'should not be voteable by its creator' do
    comment = FactoryGirl.create(:comment)

    expect { comment.user.up_vote(comment) }.to change(comment, :plusminus).by(0)
  end
end
