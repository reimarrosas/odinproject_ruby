# frozen_string_literal: true

def stock_picker(stock_prices)
  left = 0
  right = 1
  max = stock_prices[right] - stock_prices[left]
  res = [left, right]
  while right < stock_prices.length
    current_price = stock_prices[right] - stock_prices[left]
    if stock_prices[left] < stock_prices[right] && max < current_price
      max = current_price
      res = [left, right]
    else
      left = right
    end
    right += 1
  end
  res
end

puts stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
