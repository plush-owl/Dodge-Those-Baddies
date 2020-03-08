extends RigidBody2D



export var min_speed = 100 #min speed range
export var max_speed = 150 #max speed range
var clean_types = ["walk"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = clean_types[randi() % clean_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	



func _on_start_game():
	queue_free()

