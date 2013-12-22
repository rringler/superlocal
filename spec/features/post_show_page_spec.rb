require 'spec_helper'

describe 'Post#show page' do
  before(:each) do
    @user = FactoryGirl.create(:confirmed_user)
    @board = Board.create({ title:       "Cabrillo National Monument",
                            description: "1800 Cabrillo Memorial Dr., "\
                                         "San Diego, CA 92106",
                            slug:        "1800-cabrillo-memorial-dr-92106" })
    @post = FactoryGirl.create(:post, user: @user, board: @board)
    @comments = FactoryGirl.create_list(:comment, 4, post: @post)

    visit board_post_path(@board, @post)
  end

  context 'when a user is signed in' do
    before(:each) do
      visit root_path

      fill_in 'user_login',    with: @user.username
      fill_in 'user_password', with: @user.password

      click_button 'Sign in'

      visit board_post_path(@board, @post)
    end

    it 'should show the board that the post was posted to' do
      page.find('div.board').should have_css('h2')
    end

    it 'should show the post details' do
      page.find('div.post-title').should have_css('h4')
      page.find('div.post-text').should have_css('p', text: @post.text)
    end

    it 'should have a subscribe button' do
      page.should have_button('Subscribe')
    end

    it 'should have a reply link' do
      page.find('div.post-reply').should have_link('Reply')
    end

     it 'should show the new comment form when the new comment link is clicked' do
      page.find('div.post-reply').click_link 'Reply'

      page.should have_css('label', text: 'Commenting as:')
      page.find('input#comment_post_id').value.should eq(@post.id.to_s)
      page.find('input#comment_parent_id').value.should be_nil
      page.should have_field('comment[text]')
    end

    it 'should create a new post when the form is submitted' do
      page.find('div.post-reply').click_link 'Reply'

      fill_in 'comment[text]',  with: "This is a new comment reply."

      expect { click_button 'Save' }.to change(Comment, :count).by(1)
    end

    it 'should create a new subscription when the subscribe button is clicked' do
      click_button 'Subscribe'

      @user.follow_count.should eq(1)
    end
  end

  context 'when a user is not signed in' do
    it 'should show the board that the post was posted to' do
      page.find('div.board').should have_css('h2')
    end

    it 'should show the post details' do
      page.find('div.post-title').should have_css('h4')
      page.find('div.post-text').should have_css('p', text: @post.text)
    end

    it 'should not have a subscribe button' do
      page.should_not have_button('Subscribe')
    end

    it 'should have a reply link' do
      page.find('div.post-reply').should have_link('Reply')
    end

     it 'should redirect to the '\
        'new_user_session_path when the new comment link is clicked' do
      page.find('div.post-reply').click_link 'Reply'

      current_path.should eq(new_user_session_path)
      page.should have_css('h2', text: 'Sign in')
      page.should have_field('user[login]')
      page.should have_field('user[password]')
    end
  end
end