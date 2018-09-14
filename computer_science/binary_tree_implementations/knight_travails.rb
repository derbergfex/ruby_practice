class Knight
	attr_accessor :x, :y, :parent, :moves, :moves_coords

	def initialize(x, y, parent = nil)
		@x = x
		@y = y
		@parent = parent
	end

	def make_moves_tree
		all_moves = [[@x + 2, @y + 1], [@x + 1, @y + 2], [@x - 1, @y + 2], 
								[@x - 2, @y + 1], [@x - 2, @y - 1], [@x - 1, @y - 2],
								[@x + 1, @y - 2], [@x + 2, @y - 1]]
		moves = all_moves.select {|move| (move[0] >= 0 && move[0] <= 7) && (move[1] >= 0 && move[1] <= 7)}
		@moves_coords = moves
		@moves = moves.map {|move| Knight.new(move[0], move[1], self)}  # Each possible valid move is a Knight object with a parent and children.
	end
end

# We use the breadth-first approach in this method to obtain the quickest (obtainable) route.
def quickest_route(start_coords, end_coords) 
	start = Knight.new(start_coords[0], start_coords[1])
	target = Knight.new(end_coords[0], end_coords[1])
	queue = []
	path = [start]
	current = start
	until (current.x == target.x) && (current.y == target.y)
		current.make_moves_tree.each do |move|
			queue << move
		end
		next_position = queue.shift
		current = next_position
		path << current
	end
	
	quickest_route = filter_path(path)
	puts "You made it in #{quickest_route.length} moves! Here's your path:"
	quickest_route.each do |obj|
		puts "[#{obj.x}, #{obj.y}] "
	end
end

# This is to filter all the unnecessary moves.
def filter_path(path) 
	quickest_route = [path[-1]]
	current_target = path.pop
	while path.length > 0
		candidate = path.pop
		current_target.make_moves_tree  # A side step to be able to compare coordinates.
		if current_target.moves_coords.include?([candidate.x, candidate.y])
			quickest_route << candidate
			current_target = candidate
		end
	end
	quickest_route.reverse
end

quickest_route([7,7], [0,1])
		
	
