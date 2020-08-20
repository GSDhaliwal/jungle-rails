class Admin::CategoriesController < ApplicationController
  
  Rails.configuration.authentication = {
    :username => ENV['USERNAME'],
    :password => ENV['PASSWORD']
  }

  http_basic_authenticate_with name: Rails.configuration.authentication[:username], password: Rails.configuration.authentication[:password]
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
