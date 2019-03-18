class CSVWriter
  def initialize(path_to_file)
    @csv_file = CSV.open(path_to_file, 'wb')
    @csv_file << ['sep=,']
  end

  def writeHeaders(headers)
    @csv_file << headers
  end

  def writeRow(row)
    @csv_file << row
  end

  def getProductRow(product)
    return ["#{product.getName} - #{product.getCategory}", product.getPrice, product.getImage]
  end
end
