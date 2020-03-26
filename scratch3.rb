#testing num_to_be_discounted 
#testing item_less_discounted

item = {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3}
coupon = {:item => "AVOCADO", :num => 2, :cost => 5.00}

def num_to_be_discounted(item, coupon)
  num_of_reg_price = item[:count] % coupon[:num]
  item[:count] - num_of_reg_price
end

def item_less_discounted(item, coupon)
  item[:count] -= num_to_be_discounted(item, coupon)
  item
end


p num_to_be_discounted(item, coupon)
p item_less_discounted(item, coupon)