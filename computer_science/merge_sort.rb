def merge_sort(arr)
  if arr.length < 2
    return arr
  else
		a = merge_sort(arr[0...(arr.length/2)])
		b = merge_sort(arr[(arr.length/2)..-1])
		puts a.inspect
		puts b.inspect
		
		c = []
		until a.empty? || b.empty?
			c << (a[0] <= b[0] ? a.shift : b.shift)
		end
		c + a + b
	end
end

puts merge_sort([8,3,2,9,7,1,5,4]).inspect

