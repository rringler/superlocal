require 'spec_helper'

describe User do
  it 'should have valid factories' do
    FactoryGirl.create(:user).should be_valid
    FactoryGirl.create(:confirmed_user).should be_valid
  end

  describe 'validations' do
    describe 'username' do
      it 'should be present' do
        FactoryGirl.build(:user, username: nil).should_not be_valid
      end

      it 'should be unique' do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.build(:user, username: user1.username).should_not be_valid
      end

      it 'should not be case sensitive' do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.build(:user, username: user1.username.downcase).should_not be_valid
      end
    end

    describe 'email' do
      it 'should be present' do
        FactoryGirl.build(:user, email: nil).should_not be_valid
      end

      it 'should be unique' do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.build(:user, email: user1.email).should_not be_valid
      end

      it 'should not be case sensitive' do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.build(:user, email: user1.email.downcase).should_not be_valid
      end
    end
  end

  describe 'instance methods' do
    let(:user) { FactoryGirl.create(:user) }

    describe '#up_vote' do
      let(:post) { FactoryGirl.create(:post) }

      context 'when the voteable object was created by another user' do
        it 'should increment the plusminus tally if '\
           'the user has not already upvoted the object' do
          expect { user.up_vote(post) }.to change(post, :plusminus).by(1)
        end

        it 'should delete the previous upvote if '\
           'the user has already upvoted the object' do
          user.up_vote(post)
          expect { user.up_vote(post) }.to change(post, :plusminus).by(-1)
        end
      end

      context 'when the voteable object was created by the user' do
        it 'should not increment the plusminus tally' do
          expect { post.user.up_vote(post) }.to change(post, :plusminus).by(0)
        end
      end
    end

    describe '#down_vote' do
      let(:post) { FactoryGirl.create(:post) }

      context 'when the voteable object was created by another user' do
        it 'should decrement the plusminus tally if '\
           'the user has not already downvoted the object' do
          expect { user.down_vote(post) }.to change(post, :plusminus).by(-1)
        end

        it 'should delete the previous downvote if '\
           'the user has already downvoted the object' do
          user.down_vote(post)
          expect { user.down_vote(post) }.to change(post, :plusminus).by(1)
        end
      end

      context 'when the voteable object was created by the user' do
        it 'should not decrement the plusminus tally' do
          expect { post.user.down_vote(post) }.to change(post, :plusminus).by(0)
        end
      end
    end

    describe '#toggle_following' do
      let(:followable_object) { FactoryGirl.create(:board) }

      it 'should follow the object if '\
         'the user is not already following the object' do
          expect { user.toggle_following(followable_object) }.to change(user, :follow_count).by(1)
      end

      it 'should unfollow the object if '\
         'the user is already following the object' do
          user.toggle_following(followable_object)
          expect { user.toggle_following(followable_object) }.to change(user, :follow_count).by(-1)
      end
    end
  end
end
