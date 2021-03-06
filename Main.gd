extends Node


export (PackedScene) var Mob
export (PackedScene) var Clean

var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()



func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$CleanTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Music.play()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	#$HUD/MessageTimer.stop
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_StartTimer_timeout():
	$MobTimer.start()
	$CleanTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	#Choose a random Location on Path2D
	$MobPath/MobSpawnLocation.offset = randi()
	#Create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	#Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	#Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	#Set the velocity (speed & direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction)
	#mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
# warning-ignore:return_value_discarded
	$HUD.connect("start_game", mob, "_on_start_game")




func _on_CleanTimer_timeout():
	$MobPath2/MobSpawnLocation2.offset = randi()
	var clean = Clean.instance()
	add_child(clean)
	var direction = $MobPath2/MobSpawnLocation2.rotation + PI /2
	clean.position = $MobPath2/MobSpawnLocation2.position
	direction += rand_range(-PI / 4, PI / 4)
	clean.rotation = direction
	clean.linear_velocity = Vector2(rand_range(clean.min_speed, clean.max_speed), 0).rotated(direction)
	




func _on_Player_body_entered():
	pass # Replace with function body.
