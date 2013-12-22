require 'spec_helper'

describe 'Boards#show page' do
  before(:each) do
    @user = FactoryGirl.create(:confirmed_user)
    @board = Board.create({ title:       "Cabrillo National Monument",
                            description: "1800 Cabrillo Memorial Dr., "\
                                         "San Diego, CA 92106",
                            slug:        "1800-cabrillo-memorial-dr-92106" })
    @root_posts = FactoryGirl.create_list(:post, 4, user: @user, board: @board)

    @children_posts = @root_posts.map do |root_post|
      FactoryGirl.create(:post, user: @user,
                                board: @board,
                                parent: root_post)
    end

    # stub out the AddressService.slug method to avoid USPS API hit
    AddressValidator.any_instance
                    .stub(:slug)
                    .and_return("1800-cabrillo-memorial-dr-92106")
  end

  context 'when the user is signed in' do
    before(:each) do
      visit root_path

      fill_in 'user_login',    with: @user.username
      fill_in 'user_password', with: @user.password

      click_button 'Sign in'

      visit root_path

      fill_in 'address[address2]', with: "1800 Cabrillo Memorial Dr."
      fill_in 'address[city]',     with: "San Diego"
      fill_in 'address[state]',    with: "CA"
      fill_in 'address[zip5]',     with: "92106"

      click_button 'Find'
    end

    it 'should have a create new post link' do
      page.should have_link('Create new post')
    end

    it 'should have a subscribe button' do
      page.should have_button('Subscribe')
    end

    it 'should show the new post form when the new post link is clicked' do
      click_link 'Create new post'

      page.should have_css('h2', text: 'Create a post')
      page.should have_field('post[title]')
      page.should have_field('post[link]')
      page.should have_field('post[text]')
    end

    it 'should create a new post when the form is submitted' do
      click_link 'Create new post'

      fill_in 'post[title]', with: "Brand New Post"
      fill_in 'post[text]',  with: "This is a new post."

      expect { click_button 'Create' }.to change(Post, :count).by(1)
    end

    it 'should create a new subscription when the subscribe button is clicked' do
      click_button 'Subscribe'

      @user.follow_count.should eq(1)
    end

    context 'when the board has posts' do
      it 'should display the most recent posts' do
        #save_and_open_page

        @root_posts.each do |root_post|
          page.should have_css('h4', text: root_post.title)
        end

        @children_posts.each do |child_post|
          page.should have_css('h4', text: child_post.title)
        end
      end
    end
  end

  context 'when the user is not signed in' do
    before(:each) do
      visit root_path

      fill_in 'address[address2]', with: "1800 Cabrillo Memorial Dr."
      fill_in 'address[city]',     with: "San Diego"
      fill_in 'address[state]',    with: "CA"
      fill_in 'address[zip5]',     with: "92106"

      click_button 'Find'
    end

    it 'should redirect to the sign_in page when the new post link is clicked' do
      page.should_not have_field('post[title]')
      page.should_not have_field('post[link]')
      page.should_not have_field('post[text]')

      click_link 'Create new post'

      current_path.should eq(new_user_session_path)
      page.should have_css('h2', text: 'Sign in')
      page.should have_field('user[login]')
      page.should have_field('user[password]')
    end

    context 'when the board has posts' do
      it 'should display the most recent posts' do
        page.should have_css('h4', text: @root_posts[0].title)
      end
    end
  end
end
