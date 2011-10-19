class HomeController < ApplicationController
  before_filter :signature_required, :only => :signature_verify

  def index
    @users = User.all
  end

  def signature_check
    current_auth.authenticate!(request, params)
    @content = current_auth.to_s.gsub("\n", "<br />")
  end

  def signature_verify
    render :text => "#{t('http.c200')} #{t('msg.signature_success')}"
  end
end
