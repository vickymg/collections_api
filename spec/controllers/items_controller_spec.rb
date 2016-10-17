require 'rails_helper'

describe ItemsController, type: :controller do

  render_views

  before do
    @test_collection = Collection.create(name: "Sample Collection")
    Item.create(name: "Sample Item", description: "A shiny new item", collection_id: @test_collection.id)
  end

  it 'displays the item for the correct collection from the database' do
    get :index, collection_id: @test_collection.id
    parsed_body = JSON.parse(response.body)
    expect(response).to be_success
    expect(parsed_body.last).to eq({"item"=> {"id"=> 1, "name"=> 'Sample Item', "description"=> "A shiny new item", "picture"=> nil}})
  end

  it 'creates the item in the database with the appropriate collection id' do
    expect do
      post :create, {name: "Sample item 2", description: "New sample item", picture: nil, format: 'json'}
    end.to change(Item, :count).by(1)
  end

  it "the requests support CORS headers" do
    get :index, collection_id: @test_collection.id

    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    expect(response.headers['Access-Control-Allow-Methods']).to eq('POST, GET, OPTIONS')
  end
end
