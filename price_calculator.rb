ITEMS = {
  "milk" => { unit: 3.97, sale_qty: 2, sale_price: 5.00 },
  "bread" => { unit: 2.17, sale_qty: 3, sale_price: 6.00 },
  "banana" => { unit: 0.99 },
  "apple" => { unit: 0.89 }
}

puts "Please enter all the items purchased separated by a comma"
input = gets.chomp
my_cart = Hash.new(0)
order_items = input.split(',')
order_items.each do |item|
  item = item.strip.downcase
  my_cart[item] += 1 if ITEMS.key?(item)
end

total_price = 0
total_price_without_sale = 0
bill = []
my_cart.each do |item, qty|
  item_info = ITEMS[item]
  total_price_without_sale += item_info[:unit] * qty
  price = 0
  if item_info[:sale_qty] && item_info[:sale_price]
    sale_sets = qty / item_info[:sale_qty]
    remender_qty = qty % item_info[:sale_qty]
    price += sale_sets * item_info[:sale_price]
    price += remender_qty * item_info[:unit]
  else
    price += qty * item_info[:unit]
  end

  total_price += price
  bill << [item.capitalize, qty, format("$%.2f", price)]
end

total_saving = total_price_without_sale - total_price

# puts bill.inspect
puts
puts "Item      Quantity      Price"
puts "------------------------------------"
bill.each do |row|
  puts "%-10s %-12d %s" % row
end
puts "Total price : #{format("$%.2f", total_price)}"
puts "You saved #{format("$%.2f", total_saving)} today."
