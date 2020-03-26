require 'pp'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  item_counter = 0 
  while item_counter < collection.length do 
    if collection[item_counter][:item] == name
      return collection[item_counter]
    end
    item_counter += 1
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  index = 0  
  while index < cart.length do
    item_w_count_key = add_count_key(cart[index])
    position_in_new_cart = find_item_return_index(cart[index][:item], new_cart)
    item_exists = find_item_by_name_in_collection(item_w_count_key[:item], new_cart)
     
    if item_exists
      new_cart[position_in_new_cart][:count] += 1
    else
      new_cart << item_w_count_key
    end
    puts " #{index} #{item_w_count_key[:item]} #{item_w_count_key[:count]} #{!!item_exists} #{new_cart.inspect}"
    index += 1
  end
  new_cart
end

# First-order helper methods for consolidate_cart

#1 adds :count=>1 to item hash 
def add_count_key(item)
  item[:count] = 1
  item
end 

#2 returns index of matched hash or nil if not found
def find_item_return_index(name, collection)
  item_counter = 0 
  while item_counter < collection.length do 
    if collection[item_counter][:item] == name
      return item_counter
    end
    item_counter += 1
  end
  nil
end

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


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
