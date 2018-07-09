def consolidate_cart(cart)
  # code here
  new_cart = {}

  cart.each do |items_array|
    items_array.each do |item, info|
      if new_cart[item] == nil
        new_cart[item] = info
        new_cart[item][:count] = 1
      else
        new_cart[item][:count] += 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
coupons.each do |coupon|
#each element in coupons is assingned variable coupon
item_name = coupon[:item]
#varible item_name = value of coupon[:item] key
if cart.include?(item_name) && cart[item_name][:count] >= coupon[:num]
# if item_name in cart && # of item in cart is greater or = to coupon[:num] key value
if cart["#{item_name} W/COUPON"]
#if inside cart theres #{item_name} with coupon is true
cart["#{item_name} W/COUPON"][:count] += 1
#increase count by 1
else
#if not item isnt included in cart or count isnt greater than
cart["#{item_name} W/COUPON"] = {:count => 1, price: coupon[:cost], clearance: cart[item_name][:clearance]}
#2 cart #{item_name...} key add data above after = .....
end
cart[item_name][:count] -= coupon[:num]
#
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, |
    if cart[item][:clearance] == true
      cart[item][:price] -= cart[item][:price]* 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  finished_cart = apply_clearance(coupon_cart)

  cart_total = 0
  finished_cart.each do |item, item_data|
    cart_total += item_data[:price] * item_data[:count]
  end
  if cart_total > 100
    cart_total -= (cart_total * 0.10)
  end
   cart_total
end
