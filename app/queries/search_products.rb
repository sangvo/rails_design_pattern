class SearchProducts
  attr_accessor :products

  def initialize(products:)
    @products = products
  end

  def call(search_params)
    scoped = search(products, search_params[:q])
    scoped = filter_by_price(scoped, search_params[:price_from], search_params[:price_to])
    scoped = filter_by_category(scoped, search_params[:category_id])
    scoped = sort(scoped, search_params[:sort_field], search_params[:sort_direction])
    scoped = paginate(scoped, search_params[:page], search_params[:per_page])
    scoped
  end

  private

  def search scoped, query = nil
    query ? scoped.where("title LIKE ?", "%#{query}%") : scoped
  end

  def filter_by_price scoped, price_from = nil, price_to = nil
    scoped = price_from ? scoped.where("price >= ?", price_from) : scoped
    price_to ? scoped.where("price <= ?", price_to) : scoped
  end

  def filter_by_category scoped, category_id
    category_id ? scoped.where(category_id: category_id) : scoped
  end

  def sort scoped, sort_field, sort_direction, default = {order: :price, sort: :desc}
    allowed_fields = %w(price created_at)
    order_by_field = allowed_fields.include?(sort_field) ? sort_field : default[:order]
    order_direction = %w(asc desc).include?(sort_direction) ? sort_direction : default[:sort]

    scoped.order({order_by_field => order_direction})
  end

  def paginate scoped, page, per_page
    scoped.page(page).per(per_page) # kaminari
  end
end
