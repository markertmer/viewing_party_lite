require 'rails_helper'

RSpec.describe 'user dashboard', type: :feature do
  before :each do
    @user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")

    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "asdf")
    click_button("Login")
  end

  it 'has the specified info' do
    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("#{@user.name}'s Dashboard")
    expect(page).to have_button("Discover Movies")
    expect(page).to have_content("Viewing Parties")
    click_button("Discover Movies")
    expect(current_path).to eq("/discover")
  end
end
