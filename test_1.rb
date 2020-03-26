#testing apply_coupons
groceries = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 4 },
  {:item => "BEER", :price => 12.00, :clearance => true, :count => 5 },
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1 },
  {:item => "CHEESE", :price => 8.00, :clearance => false, :count => 7 },
  {:item => "ORANGES", :price => 0.75, :clearance => false, :count => 8 }
]

grocery_coupons = [ 
    {:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
]


def apply_coupons(cart, coupons)
  cart_no_coupons = []
  cart_w_coupons = []
  coupon_index = 0 
  while coupon_index < coupons.length do
    cart_index = 0 
    while cart_index < cart.length do
      current_coupon = coupons[coupon_index]
      current_item = cart[cart_index]
      #puts "#{coupon_index.to_s}, #{cart_index.to_s}"
      if current_item[:item] == current_coupon[:item]
        #puts "matched"
       
       #why is one shovel operation effecting the other? 
       #becasue working on same variables?
        cart_no_coupons << item_less_discounted(current_item, current_coupon)
        cart_w_coupons << discounted_items(current_item, current_coupon)
        
      #is not targeting non-couponed items...  
      elsif !find_item_by_name_in_collection(current_item[:item], coupons) && !find_item_by_name_in_collection(current_item[:item], cart_no_coupons)
        cart_no_coupons << current_item
      end
      cart_index += 1 
    end
    coupon_index += 1 
  end 
  cart_no_coupons
  #cart_w_coupons
  #cart_no_coupons + ["break"] + cart_w_coupons
end

#helper methods for apply_coupons

#returns hash if name is present in hash, nil if nothing matches
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

#returns number of items to be discounted (Int)
def num_to_be_discounted(item, coupon)
  num_of_reg_price = item[:count] % coupon[:num]
  item[:count] - num_of_reg_price
end

#returns hash of item with reduced :count value 
def item_less_discounted(item, coupon)
  new_item = item
  new_item[:count] = new_item[:count] % coupon[:num] 
  new_item
end

#returns hash of discounted item
def discounted_items(item, coupon)
  new_item = item
  new_item[:item] = "#{new_item[:item]} W/COUPON"
  new_item[:price] = coupon[:cost] / coupon[:num]
  new_item[:count] = num_to_be_discounted(new_item, coupon)
  new_item
end

#p find_item_by_name_in_collection("AVOCADO", groceries)
#p find_item_by_name_in_collection("KALE", groceries)

pp apply_coupons(groceries, grocery_coupons)

#p num_to_be_discounted(groceries[1], grocery_coupons[1])
#p item_less_discounted(groceries[3], grocery_coupons[2])	
#p discounted_items(groceries[1], grocery_coupons[1])

	