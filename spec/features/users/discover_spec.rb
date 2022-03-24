require 'rails_helper'

RSpec.describe 'discover movies', type: :feature do
  describe 'happy paths' do
    it 'has the specified info' do
      user = User.create(name: "Jill Jillian", email: "jill@gmail.com")
      visit "/users/#{user.id}/discover"
      expect(page).to have_content("Discover Your Next Favorite Movie")
      expect(page).to have_button("Top Rated Movies")
      expect(page).to have_content("Search Movies by Title")
      expect(page).to have_form("Title")
      expect(page).to have_button("Search")
    end

    it 'top rated movies' do
      user = User.create(name: "Jill Jillian", email: "jill@gmail.com")

      VCR.use_cassette('top_rated_movies', re_record_interval: 2.days) do
        visit "/users/#{user.id}/discover"
        click_button("Top Rated Movies")
        expect(current_path).to eq("/users/#{user.id}/movies?q=top%20rated")
        expect(page.status_code).to eq(200)
        expect(page).to have_content("1. The Shawshank Redemption")
        expect(page).to have_content("Rating: 8.7")
      end
    end

    it 'search results' do
      user = User.create(name: "Jill Jillian", email: "jill@gmail.com")

      VCR.use_cassette('search_results', re_record_interval: 2.days) do
        visit "/users/#{user.id}/discover"
        fill_in :title, with: 'lebowski'
        click_button 'search'
        expect(current_path).to eq("/users/#{user.id}/movies?q=lebowski")
        expect(page).to have_content("The Big Lebowski")
        expect(page).to have_content("Rating: 7.9")
      end
    end
  end
end
