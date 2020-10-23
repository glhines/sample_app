require 'rails_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App" 
  end

  describe "GET 'home'" do

    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        # response.should be_success
		expect(response).to have_http_status(:success)
      end

      it "should have the right title" do
        # response.should have_selector("title",
        #                              :content => "#{@base_title} | Home")
        expect(response.body).to have_title(@base_title + " | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(FactoryBot.create(:user))
        other_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        expect(response.body).to have_link("0 following",
                                            href: following_user_path(@user))
        expect(response.body).to have_link("1 follower",
                                            href: followers_user_path(@user))
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'contact'
      expect(response.body).to have_title(@base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'about'
      expect(response.body).to have_title(@base_title + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'help'
      expect(response.body).to have_title(@base_title + " | Help")
    end
  end

end
