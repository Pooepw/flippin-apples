extends Node

# yeah i think this global is important

# opens and reads a room file with FileAccess. Returns an array of strings 
# representing paths too rooms.
func open_and_read_room_file(file):
	var room_file = FileAccess.open(file, FileAccess.READ)
	var rooms = []
	while not room_file.eof_reached():
		var line = room_file.get_line()
		if not line == "":
			#print("line " + line)
			rooms.push_back(line)
	room_file.close()
	return rooms

func open_and_read_file(file):
	var string_file = FileAccess.open(file, FileAccess.READ)
	var strings = []
	while not string_file.eof_reached():
		var line = string_file.get_line()
		if not line == "":
			#print("line " + line)
			strings.push_back(line)
	string_file.close()
	return strings
