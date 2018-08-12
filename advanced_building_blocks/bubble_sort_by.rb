=begin
Now create a similar method called #bubble_sort_by which sorts an array by accepting a block. 
Remember to use yield inside your method definition to accomplish this. 
The block will have two arguments that represent the two elements of the array that are currently being compared. 
The block’s return will be similar to the spaceship operator you learned about before: 
If the result of the block execution is negative, the element on the left is “smaller” than the element on the right. 
0 means both elements are equal. A positive result means the left element is greater. 
Use the block’s return value to sort your array. 
=end

def bubble_sort_by(array)
    for i in 0..(array.length - 1)
        for j in 0..(array.length - 2)
            difference = yield(array[j], array[j + 1])
            if difference > 0
                array[j], array[j + 1] = array[j + 1], array[j]
            end
        end
    end
    puts array.inspect
end

bubble_sort_by([5,3,2]) do |left,right|
    left - right
end