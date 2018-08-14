module Enumerable 

    def my_each
        return to_enum(:my_each) unless block_given?

        if self.is_a? Hash 
            keys = self.keys
            vals = self.values
            self.length.times do |i|
                yield(keys[i], values[i])
            end
        elsif self.is_a? Array
            self.length.times do |i|
                yield(self[i])
            end
        else
            range =* self
            range.length.times do |i|
                yield(range[i])
            end
        end
    end

    def my_each_with_index
        return to_enum(:my_each_with_index) unless block_given?

        if self.is_a? Array
            index = 0
            self.my_each do |i|
                yield(i, index)
                index += 1
            end
        else
            index = 0
            self.my_each do |key, val|
                yield([key, val], index)
                index += 1
            end
        end     
    end

    def my_select
        return to_enum(:my_select) unless block_given?

        if self.is_a? Array
            selected_array = []
            self.my_each do |i|
                selected_array << i if yield(i)
            end
            selected_array
        else
            selected_hash = {}
            self.my_each do |i, j|
                selected_hash[i] = j if yield(i, j)
            end
            selected_hash
        end
    
    def my_all?
        val = true
        if block_given?
            if self.is_a? Array
                self.my_each do |i|
                    if yield(i)
                        val = true
                    else
                        return false
                    end
                    val
                end
            else
                self.my_each do |i, j|
                    if yield(i, j)
                        val = true
                    else
                        return false
                    end
                    val
                end
            end
        elsif self.is_a? Hash
            return true
        else
            self.my_each do |i|
                if i
                    val = true
                else
                    return false
                end
            end
            val
        end
    end
    def my_any? 
		val = false 
		if block_given? 
			if self.is_a?(Array) 
				self.my_each do |i|
					if yield(i)
						return true
					else 
						val = false 
					end
				end
				val
			else 
				self.my_each do |i, j|
					if yield (i, j)
						return true 
					else 
						val = false 
					end
				end
				val 
			end
		elsif self.is_a?(Hash) 
			return true 
		else
			self.my_each do |i|
				if i 
					return true
				else 
					val = false 
				end
			end
			return val
		end
	end

	def my_none?
		val = false
		if block_given? 
			if self.is_a? Array 
				self.my_each do |i|
					if yield i
						return false
					else 
						val = true 
					end
				end
				val
			else 
				self.my_each do |i, j|
					if yield i, j
						return false 
					else 
						val = true 
					end
				end
				val 
			end
		elsif self.is_a? Hash 
			return false 
		else
			self.my_each do |i|
				if i 
					return false
				else 
					val = true
				end
			end
			val
		end
	end

	def my_count(to_match = nil) 
		match_count = 0 
		if block_given? 
			if self.is_a? Array 
				self.my_each do |i|
					if yield i
						match_count += 1
					end
				end
				match_count
			else
				self.my_each do |i, j|
					if yield i, j 
						match_count += 1					
					end
				end
				match_count
			end
		elsif to_match != nil 
			if self.is_a? Array 
				self.my_each do |i|
					match_count += 1 if i == to_match 
				end
				match_count
			else 
				self.my_each do |i, j|
					match_count += 1 if i == to_match 
				end
				match_count 
			end
		else
			self.my_each do |i|
				matches_counter += 1
			end
			match_count
		end
	end

	def my_map
		return to_enum(:my_map) unless block_given?
		if self.is_a? Array
			new_array = []
			self.my_each do |i|
				output = yield i
				new_array << output
			end
			new_array
		else 
			new_array = []
			self.my_each do |i, j|
				output = yield i, j 
				new_array << output
			end
			new_array
		end
	end

	def my_inject(arg = nil, arg2 = nil)
		total = 0 
		if block_given?
			if arg != nil 
				total = arg
				if self.is_a? Hash
					hash_to_array = self.to_a 
					hash_to_array.count.times do |n|
						curr_elem = hash_to_array[n] 
						total = yield(total,[curr_elem[0],curr_elem[1]]) 
					end
					total 
				else 
					self.my_each do |i|
						total = yield(total, i) 
					end
					return total
				end
			else
				if self.is_a? Hash 
					self.my_each do |i, j|
						total = yield(total, j) 
					end
					return total 
				else 
					self.my_each do |i|
						total = yield(total, i) 
					end
					return total
				end
			end
		else 
			if arg2 != nil 
				total = arg  
				self.my_each do |i| 
					total = total.send arg2, i 
				end
				return total
			else 
				if self.is_a? Hash
					hash_to_array = self.to_a 
					hash_to_array.count.times do |n|
						curr_elem = hash_to_array[n] 
						p curr_elem
						total = total.send arg1, [curr_elem[0], curr_elem[1]])
					end
					return total
				else 
					self.my_each do |i|
						total += i 
					end
					return total
				end
			end
		end
	end
end

