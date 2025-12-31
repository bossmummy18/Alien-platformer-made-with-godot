extends Node2D

# Bridge position in block(1,1) : x = 105 , y = -70

#ToDo :
#
#    Stop

enum status {Left,Right}
enum area {enter}
enum is_ladder {enter}

func _process(_delta) :
	
	$Camera/Coin/Coin_Label.text = str(Global.coin)
	
	$Camera.position.x = $Player.position.x
	
	if area.enter :
		
		if $Player.velocity.x == 0 :
			
			if status.Right :
				
				$Player.velocity.x = 170
			else :
				
				$Player.velocity.x = -170
	
	if Input.is_action_pressed("ui_up") :
		
		if is_ladder.enter :
			
			$Player.velocity.y = -360
			$Player/Player_Anim.hide()
			$Player/Player_climb.show()
		else :
			
			$Player/Player_Anim.show()
			$Player/Player_climb.hide()
	else :
		
		$Player/Player_Anim.show()
		$Player/Player_climb.hide()

func _on_Bridge_Area_body_entered(body) :
	
	if body.name == "Player" :
		
		area.enter = 1

func _on_Bridge_Area_body_exited(body) :
	
	if body.name == "Player" :
		
		area.enter = 0

func _on_Timer_timeout() :
	
	if status.Right :
		
		status.Right = false
		status.Left = true
	else :
		
		status.Left = false
		status.Right = true
	
	$TileMaps/BridgeMap/Bridge_Anim/Bridge_Anim/Timer.start()

func _on_Ladder_body_entered(body) :
	
	if body.name == "Player" :
		
		is_ladder.enter = 1

func _on_Ladder_body_exited(body) :
	
	if body.name == "Player" :
		
		is_ladder.enter = 0

func _on_Win_Area_body_entered(body) :
	
	if body.name == "Player" :
		
		Global.data.coin += Global.coin
		Global._Save()
		Global.coin = 0
		get_tree().change_scene("res://Scene/Menu.tscn")
