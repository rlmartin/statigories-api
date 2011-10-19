class ApiKeysController < ApplicationController
  before_filter :authenticate_partner!, :can_edit_partner

  def create
    @partner.api_keys.create
    redirect_to partner_path(@partner.id)
  end

  def destroy
    key = @partner.api_keys.find_by_id(params[:id])
    key.destroy unless key.nil?
    redirect_to partner_path(@partner.id)
  end
end
