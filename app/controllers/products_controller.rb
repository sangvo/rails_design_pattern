class ProductsController < ApplicationController
  def index
    @products = SearchProducts.new(products: Product.all).call(search_params)
    render json: {products: @products}
  end

  def search_params
    params.permit(:q, :price_from, :price_to, :category_id,
                  :sort_direction, :sort_field, :page, :per_page)
  end
end
