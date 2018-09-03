require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product,
          notice: 'Product was successfully created.' }
        format.json { render :show, status: :created,
          location: @product }
      else
        puts @product.errors.full_messages
        format.html { render :new }
        format.json { render json: @product.errors,
          status: :unprocessable_entity }
      end
    end
  end

  test "should create product" do
    assert_difference('Product.count') do

    post products_url, params: {
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title,
      }
    }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title,
      }
    }

    assert_redirected_to product_url(@product)
  end
end
