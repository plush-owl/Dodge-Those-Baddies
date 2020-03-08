extends Area2D
signal hit 
#signal immune

export var speed = 400 # How fast the player will move# Declare member variables here. Examples:
var screen_size #size of game window



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size 
	hide()
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _process(delta): # Called every frame. 'delta' is the elapsed time since the previous frame.
	var velocity = Vector2() #player movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(_body): 
	print(_body.name)
#
	if "Clean" in _body.name :
		get_tree().queue_delete(_body)
		print("absorbed", _body.name)


	else:
		hide() #Player disappears after being hit
		print("died from", _body.name)
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled",true)





func game_over():
	pass # Replace with function body.
