extends Area2D

func _on_Coin_body_entered(body) :
	
	if body.name == "Player" :
		
		Global.coin += 10
		$CollisionShape2D.queue_free()
		$Sprite.queue_free()
		$AudioStreamPlayer.play()
		$Timer.start()

func _on_Timer_timeout() :
	
	queue_free()
