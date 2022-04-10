require 'rails_helper'

RSpec.describe 'user dashboard', type: :feature do
  before :each do
    user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")
  end

  it 'has login link on homepage' do
    visit "/"

    expect(page).to have_link("Login")
    click_link("Login")
    expect(current_path).to eq("/login")
  end

  it 'happy path: user logs in' do
    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "asdf")
    click_button("Login")

    expect(current_path).to eq("/dashboard")
  end

  it 'sad path: wrong password' do
    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "blanket")
    click_button("Login")

    expect(current_path).to eq("/login")
    expect(page).to have_content("ERROR: ")
  end

  it 'sad path: wrong email' do
    visit "/login"
    fill_in("Email", with: "gary@gmail.com")
    fill_in("Password", with: "asdf")
    click_button("Login")

    expect(current_path).to eq("/login")
    expect(page).to have_content("ERROR: ")
  end
end
