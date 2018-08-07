=begin
Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string.
=end

def caesar_cipher(str, shift)
    arr = str.each_byte.to_a
    str = ""
    arr.each do |num|
        if num.between?(97, 122)
            num = (((num % 97) + shift) % 26) + 97
        elsif num.between?(65, 90)
            num = (((num % 65) + shift) % 26) + 65
        else
            num = num
        end
        
        str += num.chr       
    end

    puts str
end

caesar_cipher("What a string!", 5)
# => "Bmfy f xywnsl!"

