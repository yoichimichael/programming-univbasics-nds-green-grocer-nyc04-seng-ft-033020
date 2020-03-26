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
		{:item => "CHEESE", :num => 3, :cost => 20.00},
		{:item => "CHEESE", :num => 2, :cost => 14.00}
]


def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end 
    counter += 1
  end
  cart
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