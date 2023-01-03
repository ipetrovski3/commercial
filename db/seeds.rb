require 'csv'
goods = ['Гуми', 'Моторно Масло', 'Козметика', 'Вулканизерска Опрема']
goods.each { |good| Category.create!(name: good, cat_type: 'goods') }

# brands = %w[Michelin Dunlop Goodyear Sava Kelly Fulda Sailun Pirelli Tigar]
# brands.each { |brand| Brand.create!(name: brand, category: Category.first) }

# m_summer = ['Pilot Sport 3', 'Pilot Sport 4', 'Energy Saver', 'Primacy 3', 'Primacy 4']
# m_winter = ['Alpin 5', 'Alpin 6', 'Alpin 7', 'Alpin 8', 'Alpin 9']
# m_all_season = ['Cross Climate']

# m_summer.each { |pattern| Pattern.create(name: pattern, brand_id: 1, season: 0) }
# m_winter.each { |pattern| Pattern.create(name: pattern, brand_id: 1, season: 1) }
# m_all_season.each { |pattern| Pattern.create(name: pattern, brand_id: 1, season: 2) }

file = File.read('lib/seeds/dimensions.json')
data_hash = JSON.parse(file).symbolize_keys
doc_keys = data_hash.keys

doc_keys.each do |key|
  data_hash[key.to_s.to_sym].each do |k|
    TireDimension.create(dimension: "#{k}R#{key}")
  end
end

# 100.times do
#   p = Product.create(
#     stock: rand(30..100),
#     retail_price: rand(2500..5000),
#     pattern: Pattern.all.sample,
#     vat: '18%',
#     dimension: TireDimension.all.sample.dimension
#   )
#   ProductsService.new(p).call
# end

# stock from lib/seeds/zaliha.csv
def find_or_create_brand_from_pattern(brand_name)
  brand_name = brand_name.gsub(/\A\s+|\s+\z/, '').capitalize
  brand = Brand.find_by('name ILIKE ?', "%#{brand_name}%")
  if brand.present?
    brand
  else
    Brand.create!(name: brand_name, category: Category.first)
  end
end

def find_or_create_pattern_and_brand(pattern_name, brand_name)
  brand = find_or_create_brand_from_pattern(brand_name)
  pattern_name = pattern_name.gsub(/\A\s+|\s+\z/, '').capitalize
  pattern_name = pattern_name.gsub(/\  +/, ' ')
  puts pattern_name
  pattern = Pattern.find_by('name ILIKE ?', "%#{pattern_name}%")
  if pattern.present?
    pattern
  else
    Pattern.create(name: pattern_name, brand: brand, season: 0)
  end
end

CSV.foreach('lib/seeds/zaliha.csv', headers: true) do |row|
  pattern = find_or_create_pattern_and_brand(row[4], row[3])

  p = Product.new
  p.dimension = "#{row[0]}/#{row[1]}R#{row[2]}"
  p.stock = row[5]
  p.pattern = pattern
  p.retail_price = 0
  p.save!
  ProductsService.new(p).call
end

puts 'Seeded'
