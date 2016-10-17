require 'rails_helper'

describe CollectionsController, type: :controller do

  render_views

  before do
    @test_collection = Collection.create(name: "Sample Collection", description: "A brand new collection")
  end

  it 'displays the collections from the database' do
    get :index, collection_id: @test_collection.id
    parsed_body = JSON.parse(response.body)
    expect(response).to be_success
    expect(parsed_body.last).to eq({"collection"=> {"id"=> 1, "name"=> 'Sample Collection', "description"=> "A brand new collection"}})
  end

  it 'creates a new collection in the database' do
    expect do
      post :create, {name: "DVDs", description: "My DVD collection", format: 'json'}
    end.to change(Collection, :count).by(1)
  end

  it "the requests support CORS headers" do
    get :index, collection_id: @test_collection.id

    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    expect(response.headers['Access-Control-Allow-Methods']).to eq('POST, GET, OPTIONS')
  end
end
