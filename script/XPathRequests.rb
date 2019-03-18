class XPathRequests
  @BUTTON_NEXT = "//button[contains(., 'Cargar más productos')]"
  @PRODUCTS_HREF = "//ul[@id='product_list']//li/div/div/div/a/@href"
  @ATTRIBUTES = "//div[@id='attributes']//ul//li"
  @PRODUCT_NAME = "//h1[@itemprop='name']"
  @PRODUCT_PRICE = "*/span[2]"
  @PRODUCT_IMAGE = "//img[@itemprop='image' and @id='bigpic']/@src"
  @PRODUCT_CATEGORY = "*/span[1]"

  class << self
    attr_accessor :BUTTON_NEXT,
                  :PRODUCTS_HREF,
                  :ATTRIBUTES,
                  :PRODUCT_NAME,
                  :PRODUCT_PRICE,
                  :PRODUCT_IMAGE,
                  :PRODUCT_CATEGORY
  end

end
