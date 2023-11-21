# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
    @name = @representative.name
    @ocdid = @representative.ocdid
    @title = @representative.title
    @address = @representative.address
    @party = @representative.party
    render 'representatives/show'
  end
end