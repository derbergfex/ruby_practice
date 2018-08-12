=begin 
Build a method #bubble_sort that takes an array and returns a sorted array. 
It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn’t it?).
=end

def bubble_sort(array)
    for i in 0..(array.length - 1)
        for j in 0..(array.length - 2)
            if array[j] > array[j + 1]
                array[j], array[j + 1] = array[j + 1], array[j]
            end
        end
    end
    array
end

puts bubble_sort([3,1,5,6,2,4]).inspect

