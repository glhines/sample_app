require 'rails_helper'

RSpec.describe "Users", type: :feature do
#  describe "GET /users" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get users_index_path
#      response.status.should be(200)
#    end
#  end

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        expect do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          # response.should render_template('users/new')
          # response.should have_selector("div#error_explanation")
          expect(page).to have_selector("div#error_explanation")
        end.not_to change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user" do
        expect do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          # response.should have_selector("div.flash.success",
          #                               :content => "Welcome")
          # response.should render_template('users/show')
          expect(page).to have_selector("div.flash.success", :text => "Welcome")
          expect(page).to have_current_path(user_path(1))
        end.to change(User, :count).by(1)
      end

    end
    
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        user = FactoryBot.create(:user)
        user.email = ""
        user.password = ""
        integration_sign_in user
        # response.should have_selector("div.flash.error", :content => "Invalid")
        expect(page).to have_selector("div.flash.error", :text => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = FactoryBot.create(:user)
        integration_sign_in user
        # controller.should be_signed_in
        # expect(signed_in?).to be_true
        expect(page).to have_content("Name " + user.name)
        click_link "Sign out"
        # controller.should_not be_signed_in
        expect(current_path).to eq(root_path)
      end
    end
  end
  
end
