extends Node

var in_game = false
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('pause') and in_game:
		pause_unpause()

func pause_unpause():
	var pause_menu = $"../Level/UI/PauseMenu"
	if paused:
		pause_menu.hide()
		#Engine.time_scale = 1
		get_tree().set_pause(false)
	else:
		pause_menu.show()
		#Engine.time_scale = 0
		get_tree().set_pause(true)
	paused = !paused
