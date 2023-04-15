class ApplicationController < Sinatra::Base
  # Set default content type for responses to application/json
  before do
    content_type 'application/json'
  end

  # Route to get all bakeries as JSON array
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end

  # Route to get a single bakery with nested baked goods by id as JSON
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    # Include baked goods association as nested array in the JSON
    bakery.to_json(include: :baked_goods)
  end

  # Route to get baked goods sorted by price in descending order as JSON
  get '/baked_goods/by_price' do
    baked_goods = BakedGood.order(price: :desc)
    baked_goods.to_json
  end

  # Route to get the most expensive baked good as JSON
  get '/baked_goods/most_expensive' do
    most_expensive_baked_good = BakedGood.order(price: :desc).first
    most_expensive_baked_good.to_json
  end
end
