class PartnersController < ApplicationController
  before_filter :authenticate_partner!

  def show
    @partner = Partner.find(params[:id])

  end
end
