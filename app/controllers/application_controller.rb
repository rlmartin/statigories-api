class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_auth
    @auth = @auth || Util::AuthResult.new
  end

  def can_edit_partner
    @partner = Partner.find_by_id(params[:partner_id]) || Partner.find_by_id(params[:id])
    (current_partner == @partner) and !current_partner.nil?
  end

  def permission_denied(msg)
    render :status => :unauthorized, :text => "#{t('http.c401')} #{msg}".strip #, :file => "public/401.html"
  end

  def signature_required
    permission_denied(current_auth.error) unless current_auth.authenticate!(request, params)
  end

  def build_signature_string(asset, method, date, private_key, params)
    Util.build_signature_string(request.api_asset, request.method, params['date'], private_key, request.non_path_parameters)
  end
end
