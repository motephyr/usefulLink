# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [   
  {id:1, name:"Gem"},   
  {id:2, name:"新聞"},   
  {id:3, name:"討論"},   
  {id:4, name:"教學"} 
] 
categories.each do |category| 
  a = Category.where(:id => category[:id])
  if a.empty?
    s = Category.new category   
    s.id = category[:id]   
    s.save
  end
end 