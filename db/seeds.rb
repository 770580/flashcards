# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#cards_list = [
#  ["dog", "bigdog"],
#  ["cat", "bigcat"],
#  ["bird", "bigbird"]
#]

#cards_list.each do |original_text, translated_text|
#  Card.create(original_text: original_text, translated_text: translated_text, review_date: Date.today.next_day(3))
#end

require 'open-uri'
words = Nokogiri::HTML(open("http://en365.ru/top100.htm"))
words.xpath().each do
