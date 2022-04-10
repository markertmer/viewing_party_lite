require 'rails_helper'

RSpec.describe 'logging out' do
  before :each do
    User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")

    visit "/login"
    fill_in("Email", with: "jill@gmail.com")
    fill_in("Password", with: "asdf")
    click_button("Login")
  end

  it 'has a link to logout when logged in' do
    expect(current_path).to eq('/dashboard')
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Login")
    expect(page).to_not have_link("Register")
  end

  it 'logs out when the link is clicked' do
    expect(current_path).to eq('/dashboard')
    click_link("Logout")
    expect(current_path).to eq('/')

    expect(page).to_not have_link("Logout")
    expect(page).to have_link("Login")
    expect(page).to have_link("Register")
  end
end
