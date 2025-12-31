extends KinematicBody2D

var velocity = Vector2()
var speed = 325
var grav = 35
var jump_power = -1000

enum status {Left,Right}
var can_move = true

var health = 3

func _ready() :
	
	$Player_Anim.play("idle")

func _physics_process(_delta) :
	
	if Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left") and can_move :
		
		velocity.x = speed
		$Player_Anim.play("walk")
		$Player_Anim.flip_h = false
		status.Left = 0
		status.Right = 1
	
	if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right") and can_move :
		
		velocity.x = -speed
		$Player_Anim.play("walk")
		$Player_Anim.flip_h = true
		status.Left = 1
		status.Right = 0
	
	if !Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left") and can_move :
		
		$Player_Anim.play("idle")
	
	if !is_on_floor() and can_move :
		
		$Player_Anim.play("jump")
	
	velocity.y += grav
	
	if Input.is_action_pressed("ui_accept") and is_on_floor() and can_move :
		
		velocity.y = jump_power
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
	velocity.x = 0
	#velocity.x = lerp(velocity.x,0,0.2)

func _on_Damage_Check_area_entered(area) :
	
	if area.name == "Damage" :
		
		health -= 1
		if health <= 0 :
			
			Global.coin = 0
			get_tree().change_scene("res://Scene/Menu.tscn")
		get_parent().get_node("Camera/Heart/Heart_Label").text = str(health)
		can_move = false
		$Player_Anim.play("hurt")
		if status.Right :
			
			velocity.y = -750
			for _i in range(20) :
				
				velocity.x = -400
				yield(get_tree().create_timer(0.0075),"timeout")
		else :
			
			velocity.y = -750
			for _i in range(20) :
				
				velocity.x = 400
				yield(get_tree().create_timer(0.0075),"timeout")
		can_move = true
