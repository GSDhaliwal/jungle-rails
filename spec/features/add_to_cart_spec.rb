require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end
  end
  
 
 
  scenario "A guest adds a product to their cart." do
    # vist the page
    visit '/'

    # hover over the first product and click add
    first("article.product").find_button('Add').click

    # Check that the number increased in my cart
    # visit the cart page

    expect(page).to have_content "My Cart (1)" 
  
    
    save_screenshot

  end

end
