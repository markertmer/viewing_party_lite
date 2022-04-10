require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  it 'exists' do
    visit "/"
    expect(current_path).to eq("/")
    expect(page).to have_content("Viewing Party PRO")
  end

  it 'has a button to create a new user' do
    visit "/"

    expect(page).to have_button("Create new user")

    click_on "Create new user"

    expect(current_path).to eq("/register")
  end

  it 'lists all existing users as links to their own dashboards' do
    user1 = User.create!(name: "Katy", email: "katy.perry@turing.io", password: "0")
    user2 = User.create!(name: "Mark", email: "mark.twain@turing.io", password: "0")
    user3 = User.create!(name: "Joe", email: "joe.jonas@turing.io", password: "0")

    visit "/"

    expect(page).to have_content("Existing users:")
    expect(page).to have_link("Katy")
    expect(page).to have_link("Mark")
    expect(page).to have_link("Joe")

    # click_on("Joe")
    #
    # expect(current_path).to eq("/dashboard")
  end

  it 'can be navigated to from any page' do
    User.create!(name: "Jesse", email: "jesse.owens@turing.io", password: "0")

    visit "/login"
    fill_in("Email", with: "jesse.owens@turing.io")
    fill_in("Password", with: "0")
    click_button("Login")

    expect(current_path).to eq("/dashboard")

    click_on("Home")

    expect(current_path).to eq("/")
    # add more pages here for this test when more are built pls -Katy
  end
end
