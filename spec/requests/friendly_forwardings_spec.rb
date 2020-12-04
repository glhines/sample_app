require 'rails_helper'

RSpec.describe "FriendlyForwardings", type: :feature do

  it "should forward to the requested page after signin" do
    user = FactoryBot.create(:user)
    visit edit_user_path(user)
    # The test automatically follows the redirect to the signin page.
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button
    # The test follows the redirect again, this time to users/edit.
    # response.should render_template('users/edit')
    expect(page).to have_current_path(edit_user_path(1))
  end
end
