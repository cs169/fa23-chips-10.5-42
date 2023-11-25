# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do

  describe "GET index" do

    it "should get all all representatives" do
      rep1 = Representative.create(name: "name1", ocdid: "ocdid1", title: "title1")
      rep2 = Representative.create(name: "name2", ocdid: "ocdid2", title: "title1")
      rep3 = Representative.create(name: "name3", ocdid: "ocdid3", title: "title1")
      get :index 
      expect(assigns(:representatives)).to eq([rep1, rep2, rep3])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    before do
      rep = Representative.create(name:     "name",
                                  ocdid:    "ocdid",
                                  title:    "title",
                                  address:  "address",
                                  party:    "party",
                                  photo:    "photo")
      get :show, params: {id: rep.id}
    end

    it "should return right name" do
      expect(assigns(:name)).to eq("name")
    end

    it "should return right ocdid" do
      expect(assigns(:ocdid)).to eq("ocdid")
    end

    it "should return right title" do
      expect(assigns(:title)).to eq("title")
    end

    it "should return right address" do
      expect(assigns(:address)).to eq("address")
    end

    it "should return right party" do
      expect(assigns(:party)).to eq("party")
    end

    it "should return right photo" do
      expect(assigns(:photo)).to eq("photo")
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

  end
end
