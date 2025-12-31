extends Node

const Save_path = "user://data-base.data"
var data = {coin = 0}

var coin = 0

func _Save() :
	
	var f = File.new()
	f.open(Save_path,2)
	f.store_string(to_json(data))
	f.close()

func _Load() :
	
	var f = File.new()
	if f.file_exists(Save_path) :
		
		f.open(Save_path,1)
		data = parse_json(f.get_as_text())
		f.close()
