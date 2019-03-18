# print "Hello World!"
require 'csv'
require 'nokogiri'
require 'curb'
require 'logger'
require_relative 'CSVWriter'
require_relative 'CSVProductRowFormatter'
require_relative 'PageParser'

#Params we get
URL = ARGV[0].sub(/\/\?p=\d+/, '')
PATH_TO_FILE = ARGV[1]
HEADERS = %w{Name Price Image}

#Parse page we have got
log = Logger.new(STDOUT)
page_parser = PageParser.new()
page_parser.parseCategoryPage(URL, log)

#Writting in a CSV file
log.info("Writting in a CSV file\n")
csv_writer = CSVWriter.new(PATH_TO_FILE)
csv_writer.writeHeaders(HEADERS)
product_list = page_parser.product_list()
product_list.each { |product|
  csv_writer.writeRow(CSVProductRowFormatter.getProductRow(product))
}
