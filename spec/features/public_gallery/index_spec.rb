require 'rails_helper'

RSpec.describe "public gallery", :vcr do
  before(:each) do
    @user = GoogleUser.new( { id: 1, attributes: { email: 'test@test.com' } } )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'display' do
    it 'shows header' do
      visit public_gallery_index_path

      within('#header') do
        expect(page).to have_content('Public Gallery')
      end

      within('#images') do
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/84d17702-2eb0-42ef-af5b-858bf3b84c58?response-content-disposition=inline%3B%20filename%3D%22IMG_7864.jpg%22%3B%20filename%2A%3DUTF-8%27%27IMG_7864.jpg']")
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/9a737cc8-dc69-461a-bda6-a2cc42958f3d?response-content-disposition=inline%3B%20filename%3D%22e03d5b812b2734826f76960eca5b5541.jpg%22%3B%20filename%2A%3DUTF-8%27%27e03d5b812b2734826f76960eca5b5541.jpg']")
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/2432ea7b-9df1-4953-97ee-f85b9e8225e0?response-content-disposition=inline%3B%20filename%3D%22PXL_20210908_214800825.MP_2.jpg%22%3B%20filename%2A%3DUTF-8%27%27PXL_20210908_214800825.MP_2.jpg']")
        expect(page).to have_css("img[src*='https://tikiarte-dev.s3.us-east-2.amazonaws.com/uploads/55c4807e-fdbf-4648-9e42-f6952dff7556?response-content-disposition=inline%3B%20filename%3D%22Reggie.JPG%22%3B%20filename%2A%3DUTF-8%27%27Reggie.JPG']")
      end
    end
  end
end
