require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "GET #index" do
    let!(:place) {create_list(:place, 1)}
    it "display one record" do 
      expect(@response.status).to eq(200)
    end
  end
end