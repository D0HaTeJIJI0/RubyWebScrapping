class Product
  def initialize(name, price, image, category)
    @name = name
    @price = price
    @image = image
    @category = category
  end

  def getName
    return @name
  end

  def getPrice
    return @price
  end

  def getImage
    return @image
  end

  def getCategory
    return @category
  end

  def to_s
    return "#{@name}: price: #{@price}, img: #{@image}"
  end
end
