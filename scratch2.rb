#testing apply_coupons

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

def apply_coupons(cart, coupons)
  cart_no_coupons = []
  cart_w_coupons = []
  coupon_index = 0 
  while coupon_index < coupons.length do
    cart_index = 0 
    while cart_index < cart.length do 
      if cart[cart_index][:item] == coupons[coupon_index][:item]
        cart_no_coupons << item_less_discounted(cart[cart_index], coupons[coupon_index])
        cart_w_coupons << discounted_items(cart[cart_index], coupons[coupon_index])
      elsif !find_item_by_name_in_collection(cart[cart_index][:item], cart_no_coupons)
        cart_no_coupons << cart[cart_index] 
      end
      cart_index += 1 
    end
    coupon_index += 1 
  end 
  cart_no_coupons + cart_w_coupons
end

#helper methods for apply_coupons

def num_to_be_discounted(item, coupon)
  num_of_reg_price = item[:count] % coupon[:num]
  item[:count] - num_of_reg_price
end

def item_less_discounted(item, coupon)
  item[:count] -= num_to_be_discounted(item, coupon)
  item
end

def discounted_items(item, coupon)
  item[:item] = "#{item[:item]} W/COUPON"
  item[:price] = coupon[:cost].to_f / coupon[:num]
  item[:count] = num_to_be_discounted(item, coupon)
  item
end  

#method body

      item = cart[cart_index]
      item[:count] -= num_to_be_discounted(item, coupons[coupon_index])
      name_w_coupon = "#{cart[cart_index][:item]} W/COUPON"
      discounted_price = coupons[coupon_index][:cost] / coupons[coupon_index][:num]
      discounted = {:item => name_w_coupon, :price => discounted_price, :clearance => true, :count => num_to_be_discounted(cart[cart_index], coupons[coupon_index]) }
      price_w_coupon = coupons[coupon_index][:cost] / coupons[coupon_index][:num]
      if cart[cart_index][:item] == coupons[coupon_index][:item]
        cart_no_coupons << item
        cart_w_coupons << discounted
      elsif !find_item_by_name_in_collection(cart[cart_index][:item], cart_w_coupons)
        cart_no_coupons << cart[cart_index]
      end
