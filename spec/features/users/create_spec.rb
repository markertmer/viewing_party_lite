require 'rails_helper'

RSpec.describe 'create a new user', type: :feature do
  it 'has a registration page' do
    visit "/register"
    expect(current_path).to eq("/register")
    expect(page).to have_content("Sign Up for your FREE Viewing Party PRO Account TODAY!")
  end

  describe 'happy path:' do
    it 'new user form' do
      visit "/register"
      fill_in("Name", with: "Biff Bliffert")
      fill_in("Email", with: "biff@bliffertsolutions.biz")
      fill_in("Password", with: "lkjasdfljk453789")
      fill_in("Confirm Password", with: "lkjasdfljk453789")
      click_button("Register")
      user = User.last
      expect(current_path).to eq("/users/#{user.id}")
      expect(user.name).to eq("Biff Bliffert")
      expect(user.email).to eq("biff@bliffertsolutions.biz")
    end
  end

  describe 'sad paths:' do
    it 'email address is not unique' do
      user = User.create(name: "Jill Jillian", email: "jill@gmail.com", password: "asdf")
      visit "/register"
      fill_in("Name", with: "Almost Jill")
      fill_in("Email", with: "jill@gmail.com")
      fill_in("Password", with: "lkjasdfljk453789")
      fill_in("Confirm Password", with: "lkjasdfljk453789")
      click_button("Register")
      expect(current_path).to eq("/register")
      expect(page).to have_content("ERROR: Email has already been taken")
    end

    it 'email address is not unique' do
      user = User.create(name: "Jill Jillian", email: "jill@gmail.com")
      visit "/register"
      fill_in("Name", with: "Jill Jillian")
      fill_in("Email", with: "jill@gmail.com")
      fill_in("Password", with: "lkjasdfljk453789")
      fill_in("Confirm Password", with: "blanket")
      click_button("Register")
      expect(current_path).to eq("/register")

      expect(page).to have_content("ERROR: Password confirmation doesn't match Password")
    end
  end
end
