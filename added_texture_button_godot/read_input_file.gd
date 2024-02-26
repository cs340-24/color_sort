@tool
extends EditorScript

func _run():
	# Open the file containing game level data, one level per line
	var file = FileAccess.open("res://1per.txt", FileAccess.READ)
	
	# Number of each level
	var level_num = 1;
	
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

				# Print level's data:
				var index = 0    # Index in the color_vals array
				var bottle_info  # Output string containing 1 bottle's info
				 
				# Print level number
				print("Level ", level_num, ":")  
				
				# Iterate through the bottles, printing info string for each one
				for i in num_bottles:
					# Add bottle number to output string
					bottle_info = "bottle %d: " % (i+1) 
					
					# Add each color val to bottle info string
					for j in num_blocks:
						bottle_info = bottle_info + "%d " % color_vals[index]
						index = index + 1
					
					# Print the bottle info string
					print(bottle_info)
				
				# Increment level number
				level_num = level_num + 1	
				
			# Prints a blank line between each level 	
			print("\n")	
			
	# If couldn't open file
	else:
		print("Could not open file.")
