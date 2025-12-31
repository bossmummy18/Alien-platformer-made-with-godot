extends Control

func _on_Start_pressed() :
	
	get_tree().change_scene("res://Scene/Level.tscn")

func _on_Exit_pressed() :
	
	get_tree().quit()

func _ready() :
	
	Global._Load()
	$Label.text = "Coin : " + str(Global.data.coin)
