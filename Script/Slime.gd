extends KinematicBody2D

var velocity = Vector2(170,0)

func _process(_delta) :
	
	move_and_slide(velocity)
	
	if is_on_wall() and velocity.x :
		
		velocity.x = -velocity.x
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _on_Area2D_body_entered(body) :
	
	if body.name == "Player" and velocity.x :
		
		Global.coin += 20
		velocity.x = 0
		$Damage.queue_free()
		$CollisionShape2D.queue_free()
		position.y += 6.5
		$AnimatedSprite.play("dead")
		$Timer.start()

func _on_Timer_timeout() :
	
	queue_free()
