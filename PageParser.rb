require_relative 'Product'
require_relative 'XPathRequests'
class PageParser
  attr_reader :product_list

  def initialize()
    @product_list = Array.new
  end

  def getParsedPageContent(url)
    page = Curl.get("#{url}") do |http|
      http.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36'
    end
    content = page.body_str
    return Nokogiri::HTML(content)
  end

  def getProductName(parsed_content)
    return parsed_content.xpath(XPathRequests.PRODUCT_NAME).inner_html
  end

  def getProductPrice(parsed_content)
    return parsed_content.xpath(XPathRequests.PRODUCT_PRICE).inner_html.sub("€/u", '')
  end

  def getProductImage(parsed_content)
    return parsed_content.xpath(XPathRequests.PRODUCT_IMAGE)
  end

  def getProductCategory(parsed_content)
    return parsed_content.xpath(XPathRequests.PRODUCT_CATEGORY).inner_html
  end

  def getProductAttributes(parsed_content)
    return parsed_content.xpath(XPathRequests.ATTRIBUTES)
  end

  def getProductHrefs(parsed_content)
    return parsed_content.xpath(XPathRequests.PRODUCTS_HREF)
  end

  def getButtonNext(parsed_content)
    return parsed_content.xpath(XPathRequests.BUTTON_NEXT)
  end

  def parseProductPage(parsed_product_content)
    self.getProductAttributes(parsed_product_content).each do |category_tag|
      product = Product.new(
        self.getProductName(parsed_product_content),
        self.getProductPrice(category_tag),
        self.getProductImage(parsed_product_content),
        self.getProductCategory(category_tag)
      )
      self.product_list.push(product)
    end
  end

  def parseCategoryPage(url, log)
    page_num = 1
    log.info("Getting page of the category from url: #{URL}\n")
    parsed_content = self.getParsedPageContent(URL)
    begin
      self.getProductHrefs(parsed_content).each do |href|
        log.info("Getting a product's page of the category from url: #{href}\n")
        parsed_product_content = self.getParsedPageContent(href)
        log.info("Parsing product page\n")
        self.parseProductPage(parsed_product_content)
      end
      page_num += 1
      log.info("---------------------------------------------\n")
      log.info("Getting page of the category from url: #{URL}?p=#{page_num}\n")
      parsed_content = self.getParsedPageContent("#{URL}?p=#{page_num}")
    end while (!self.getButtonNext(parsed_content).empty?)
  end

end
