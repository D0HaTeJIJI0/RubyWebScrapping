class CSVProductRowFormatter
  def self.getProductRow(product)
    return ["#{product.getName} - #{product.getCategory}", product.getPrice, product.getImage]
  end
end
