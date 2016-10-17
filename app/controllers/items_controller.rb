require 'json'

class ItemsController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  def index
    @items = Item.where(collection_id: params[:collection_id])
  end

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def create
    @item = Item.new(name: params[:name], description: params[:description], picture: params[:picture], collection_id: params[:collection_id])
    if @item.save
      respond_to do |format|
        format.json{render :json => @item, :status => :created}
      end
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :picture)
  end

end
