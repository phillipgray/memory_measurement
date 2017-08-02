# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_file = File.read("fin_data_sample2.json")
data_blob = JSON.parse(seed_file)

10001.upto(10010) do |company_name|
  2000.upto(2010) do |year|
    Financial.create(company: company_name.to_s, year: year, data: data_blob)
  end
end
