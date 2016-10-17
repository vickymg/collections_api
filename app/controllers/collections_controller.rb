require 'json'

class CollectionsController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  def index
    @collections = Collection.all
  end

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

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
    @collection = Collection.new(name: params[:name], description: params[:description])
    if @collection.save
      respond_to do |format|
        format.json{render :json => @collection, :status => :created}
      end
    end
  end

  def collection_params
    params.require(:collection).permit(:name, :description)
  end

end
