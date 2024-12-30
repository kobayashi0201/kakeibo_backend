class Api::V1::CategoriesController < ActionController::API
  def index
    categories = Category.all
    render json: categories, status: :ok
  end
end
