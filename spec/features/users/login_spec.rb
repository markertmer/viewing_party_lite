require 'rails_helper'

RSpec.describe 'user dashboard', type: :feature do
  it 'has link on homepage' do
    visit "/"

    expect(page).to have_link("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
  end

  it 'happy path: user logs in' do
    user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")

    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "asdf")
    click_on("Login")

    expect(current_path).to eq("/users/#{user.id}")
  end

  it 'sad path: wrong password' do
    user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")

    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "blanket")
    click_on("Login")

    expect(current_path).to eq("/login")
    expect(page).to have_content("ERROR: ")
  end

  it 'sad path: wrong email' do
    user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")

    visit "/login"
    fill_in("Email", with: "gary@gmail.com")
    fill_in("Password", with: "asdf")
    click_on("Login")

    expect(current_path).to eq("/login")
    expect(page).to have_content("ERROR: ")
  end
end
