=begin
Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. 
It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.
=end

def stock_picker(arr)
    sums = []
    for i in 0...arr.length
        for j in (i + 1)...arr.length
            sums.push([i, j])
        end
    end

    max_sum = 0
    final_arr = nil

    for i in 0...sums.length
        diff = arr[sums[i][1]] - arr[sums[i][0]]
        if (diff > max_sum)
            max_sum = diff
            final_arr = sums[i]
        end
    end
    
    puts final_arr.to_s
end

stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  # for a profit of $15 - $3 == $12