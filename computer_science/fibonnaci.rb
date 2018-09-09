def fibs(num)
  initial_array = [0, 1]
  ind = 2

  if num == 1 || num == 2
    temp = num - 1
    return initial_array[0..temp]
  end

  until initial_array.length == num
    initial_array << (initial_array[ind - 2] + initial_array[ind - 1])
    ind += 1
  end

  initial_array
end

def fibs_rec(num, arr = [0, 1])
  return arr if num == arr.length
  return arr[0..(num -1)] if num == 1 || num == 2
  fibs_rec(num - 1, arr) << arr[-1] + arr[-2]
end