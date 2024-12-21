class Api::V1::CategoriesController < ActionController::API
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
