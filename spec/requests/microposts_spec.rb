require 'rails_helper'

RSpec.describe "Microposts", type: :feature do

  before(:each) do
    user = FactoryBot.create(:user)
    visit signin_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new micropost" do
        expect do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          # response.should render_template('pages/home')
          expect(page).to have_current_path(microposts_path)
          expect(page).to have_selector("div#error_explanation")
        end.not_to change(Micropost, :count)
      end
    end

    describe "success" do

      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        expect do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          expect(page).to have_selector("span.content", :text => content)
        end.to change(Micropost, :count).by(1)
      end
    end
  end
  
end
