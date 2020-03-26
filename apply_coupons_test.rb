#testing apply_coupons
groceries = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 4 },
  {:item => "BEER", :price => 12.00, :clearance => true, :count => 5 },
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1 },
  {:item => "CHEESE", :price => 8.00, :clearance => false, :count => 7 }
]

grocery_coupons = [ 
    {:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]



def find_item_by_name_in_collection(name, collection)
  item_counter = 0 
  while item_counter < collection.length do 
    if collection[item_counter][:item] == name
      return collection[item_counter]
    end
    item_counter += 1
  end
  nil
end

#hased out if statement operations
#cart_no_coupons << item_less_discounted(current_item, current_coupon)
#cart_w_coupons << discounted_items(current_item, current_coupon)

#takes as arguments a AoH of items and AoH of coupons 
def apply_coupons(cart, coupons)
  cart_no_coupons = []
  cart_w_coupons = []
  coupon_index = 0 
  while coupon_index < coupons.length do
    cart_index = 0 
    while cart_index < cart.length do
      current_coupon = coupons[coupon_index]
      current_item = cart[cart_index]
      if current_item[:item] == current_coupon[:item]
        puts "#{coupon_index}, #{cart_index}"
      elsif !find_item_by_name_in_collection(current_item[:item], current_coupon)
        cart_no_coupons << current_item
      end
      cart_index += 1 
    end
    coupon_index += 1 
  end 
  cart_no_coupons + ["breakbreakbreak"] + cart_w_coupons
end

#helper methods for apply_coupons

#returns number of items to be discounted (Int)
def num_to_be_discounted(item, coupon)
  num_of_reg_price = item[:count] % coupon[:num]
  item[:count] - num_of_reg_price
end

#returns hash of item with reduced :count 
def item_less_discounted(item, coupon)
  item[:count] -= num_to_be_discounted(item, coupon)
  item
end

#returns hash of discounted item
def discounted_items(item, coupon)
  item[:item] = "#{item[:item]} W/COUPON"
  item[:price] = coupon[:cost].to_f / coupon[:num]
  item[:count] = num_to_be_discounted(item, coupon)
  item
end

#p apply_coupons(groceries, grocery_coupons)

#p find_item_by_name_in_collection("AVOCADO", groceries)
#p find_item_by_name_in_collection("ZEBRA", groceries)
#p num_to_be_discounted(cart[1], coupons[1])
#p discounted_items(cart[1], coupons[1])
#p item_less_discounted(cart[0], coupons[0])
