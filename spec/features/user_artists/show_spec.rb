require 'rails_helper'

RSpec.describe "artist show page", :vcr do
  before(:each) do
    @user = GoogleUser.new( { id: 3, attributes: { email: 'test@test.com' } } )
    @artist = Artist.new('reggie', 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'display' do
    it 'shows header' do
      visit user_artist_path(@user.id, @artist.id)

      expect(page).to have_content(@artist.username)

      expect(page).to have_content("Total Art Pieces: 2")

      within('#private-gallery') do
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/85b04b7f-b55e-40e8-99ec-d1a34f529ac9?response-content-disposition=attachment%3B%20filename%3D%226f663d83-69cf-47b5-a72c-d6d40ed0eeb8-ford-bronco-Gateway-06.JPG%22%3B%20filename%2A%3DUTF-8%27%276f663d83-69cf-47b5-a72c-d6d40ed0eeb8-ford-bronco-Gateway-06.JPG']")
      end

      within('#public-gallery') do
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/55c4807e-fdbf-4648-9e42-f6952dff7556?response-content-disposition=inline%3B%20filename%3D%22Reggie.JPG%22%3B%20filename%2A%3DUTF-8%27%27Reggie.JPG']")
      end
    end
  end

  describe 'link to upload page' do
    it 'can redirect to art_pieces upload page' do
      visit user_artist_path(@user.id, @artist.id)

      expect(page).to have_link("Upload an Art Piece")

      click_link "Upload an Art Piece"

      expect(current_path).to eq(new_user_artist_art_piece_path(@user.id, @artist.id))
      expect(page).to have_content("Upload an Art Piece")
      expect(page).to have_content("Name Your New Art Piece:")
      expect(page).to have_content("Describe Your Art Piece:")
      expect(page).to have_field(:art_piece_title)
      expect(page).to have_button("Create Art Piece")
    end
  end

end
