require "pry"

def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |item, new_cart|
    #binding.pry
    item.each do |name, attributes|
      #binding.pry
      if new_cart[name]
        attributes[:count] += 1
        #binding.pry
      else
        attributes[:count] = 1
        new_cart[name] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
        #binding.pry
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, attributes|
    #binding.pry
    if attributes[:clearance]
      updated_price = attributes[:price] * 0.80
      attributes[:price] = updated_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, attributes|
    binding.pry
    total += attributes[:price] * attributes[:count]
  end
  total = total * 0.9 if total > 100
  total
end
