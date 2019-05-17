class EmailBlacklistsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_action :admin_only
  before_action :load_whitelist, only: [:destroy]

  def index
    @blacklists = EmailBlacklist.search(search_params).paginate(params[:page], limit: params[:limit])
    respond_with(@blacklists)
  end

  def new
    @blacklist = EmailBlacklist.new
  end

  def create
    @blacklist = EmailBlacklist.create(blacklist_params)
    respond_with(@blacklist, location: email_blacklists_path)
  end

  def destroy
    @blacklist = EmailBlacklist.find(params[:id])
    @blacklist.destroy
    respond_with(@blacklist)
  end

  private

  def search_params
    params.fetch(:search, {}).permit(%i[order domain reason])
  end

  def blacklist_params
    params.require(:email_blacklist).permit(%i[domain reason])
  end

end