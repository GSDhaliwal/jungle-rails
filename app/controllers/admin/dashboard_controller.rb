class Admin::DashboardController < ApplicationController
  
  Rails.configuration.authentication = {
    :username => ENV['USERNAME'],
    :password => ENV['PASSWORD']
  }

  http_basic_authenticate_with name: Rails.configuration.authentication[:username], password: Rails.configuration.authentication[:password]
  
  def show
    @products = Product.all
    @categories = Category.all
  end
end
