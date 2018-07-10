
def consolidate_cart(cart)
  #consolidate_cart is going to take our cart which is an array and count the items
new_cart = {}
#this is the new cart with items
cart.each do |item|
  # we are going to do this for each item_name
  item.each do |item_name, info|
    # item_name is a hash with the  and more info in a hash
if !new_cart.has_key?(item_name)
  # if the new cart doesnt have a key in it that is the one we are working with
  new_cart[item_name] = info
  #this will now make the what we called info as the key item_name in the new cart hash
  new_cart[item_name][:count] = 1
# if that above statement is true then it will also add a new ky named count that equals one
else
  new_cart[item_name][:count] += 1
  # if the new cart does has a key with item_name then it will just increase the counter by 1

end
end
end
new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    current_item = coupon[:item]
     coupon_code = current_item + " W/COUPON"
     if cart[current_item] && cart[current_item][:count] >= coupon[:num]
       if cart[coupon_code]
         cart[coupon_code][:count] += 1
       else
         cart[coupon_code] = {
           count: 1,
           price: coupon[:cost],
           clearance: cart[current_item][:clearance]
         }
       end

       cart[current_item][:count] -= coupon[:num]
     end
   end
   cart
 end


def apply_clearance(cart)
  cart.each do |item, options|
      if cart[item][:clearance]
        cart[item][:price] = cart[item][:price] - (cart[item][:price] * 0.2)
      end
    end
    cart
   end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
   cart_with_coupon_applied = apply_coupons(consolidated_cart, coupons)
   final_cart = apply_clearance(cart_with_coupon_applied)
   total = 0.0
   final_cart.each do |item, options|
     total += options[:price] * options[:count]
   end

 if total > 100
total = total * 0.9
end
  total
end
