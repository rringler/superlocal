require 'spec_helper'

describe Post do
  it 'should have valid factories' do
    FactoryGirl.create(:post).should be_valid
  end

  describe 'validations' do
    describe 'title' do
      it 'should be present' do
        FactoryGirl.build(:post, title: nil).should_not be_valid
      end

      it 'should be less than 255 characters' do
        FactoryGirl.build(:post, title: "a" * 256).should_not be_valid
      end
    end

    describe 'board_id' do
      it 'should be present' do
        FactoryGirl.build(:post, board_id: nil).should_not be_valid
      end
    end

    describe 'user_id' do
      it 'should be present' do
        FactoryGirl.build(:post, user_id: nil).should_not be_valid
      end
    end
  end

  it 'should be voteable by other users' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)

    expect { user.up_vote(post) }.to change(post, :plusminus).by(1)
  end

  it 'should not be voteable by its creator' do
    post = FactoryGirl.create(:post)

    expect { post.user.up_vote(post) }.to change(post, :plusminus).by(0)
  end
end
