class ProductsController < ApplicationController
  def index
    # 1, 2, 3 Queries from task
    @managers_ages = ProductsService.managers_age
    @oldest_users = ProductsService.oldest_users
    @updated_products = ProductsService.updated_products

    # The user and products definitions for views
    @user, @products = current_user, ProductsService.sorted_by_roles(current_user)

    # If we want to see the updated frameworks
    params[:show_changes] && (@products = @updated_products)
  end

  def archive
    (@product = Product.find(params[:id])) && @product.update_attribute(:archived, !@product.archived)
    redirect_to root_path
  end
end