# Minimoa aurkitu behar dugu
# Minimoarekin eta hurrengo prezioarekin maximoa nahi dugu
def stock_picker (prices)
  min_price = prices[0]
  min_index = 0

  profit = 0
  best_days = [0,0]
  
  prices.each_with_index do |price, index|
    # Minimoa
    if price < min_price
      min_price = price
      min_index = index
      next # Prezio minimoa aurkituz hurrengo ez da beharrezkoa
    end
    # Gordina maximoa
    if price - min_price > profit
      profit = price - min_price
      best_days = [min_index, index]      
    end
  end
  best_days
end
  
p stock_picker([17,3,6,9,15,8,6,1,10])
