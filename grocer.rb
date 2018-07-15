def consolidate_cart(cart)
  consolcart = {}
  cart.each do |item|
    item.each do |name, stats|
      if consolcart.has_key?(name)
        consolcart[name][:count] += 1
      else
        consolcart[name] = stats
        consolcart[name][:count] = 1
      end
    end
  end
  return consolcart
end

def apply_coupons(cart, coupons)
  couponed_cart = cart.clone

   
    cart.each do |item_name, item_data|
      coupons.each do |coupon|
        if coupon[:item] == item_name && item_data[:count] - coupon[:num] >= 0
          couponed_cart[item_name][:count] -= coupon[:num] 

          if !couponed_cart.include?("#{item_name} W/COUPON")
            couponed_cart["#{item_name} W/COUPON"] = Hash.new
            couponed_cart["#{item_name} W/COUPON"][:price] = coupon[:cost]
            couponed_cart["#{item_name} W/COUPON"][:clearance] = item_data[:clearance]
            couponed_cart["#{item_name} W/COUPON"][:count] = 1
          else
            couponed_cart["#{item_name} W/COUPON"][:count] += 1
          end
        end
      end
    end
    couponed_cart
end

def apply_clearance(cart)
  cart.each do |name, stats|
    if stats[:clearance]
      newprice = stats[:price] * 0.80
      stats[:price] = newprice.round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  subtotal_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  subtotal = 0.0;
  subtotal_cart.each do |item_name, item_data|
    subtotal += item_data[:count] * item_data[:price]
  end
   subtotal > 100 ? (0.9 * subtotal).round(2) : subtotal
end