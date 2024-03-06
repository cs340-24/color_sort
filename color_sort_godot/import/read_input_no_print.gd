@tool
extends EditorScript

func _run():
	# Open the file containing game level data, one level per line
	var file = FileAccess.open("res://1per.txt", FileAccess.READ)

	# check that file opened
	if file != null:
		
		# Read each line of the file to load each level's data	
		var line
		while file.eof_reached() == false:
			line = file.get_line()

			# skip any empty lines
			if line.length() > 4:
				# separate the line into individual numbers (strings) 
				var numbers = line.split(" ")
				
				# convert the numbers from strings to ints
				var vals = Array()
				for val in numbers:
					vals.append(int(val))

				# Extract num_bottles, num_blocks, and color_vals values
				var num_bottles = vals[0]
				var num_blocks = vals[1]
				var color_vals = vals.slice(2, vals.size())


			
	# If couldn't open file
	else:
		print("Could not open file.")
