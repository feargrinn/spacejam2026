extends SubViewportContainer

var player: Player

func _ready():
	if (player):
		return
	set_process_unhandled_input(true)
	player = Player.instance

func _input(event):
	# fix by ArdaE https://github.com/godotengine/godot/issues/17326#issuecomment-431186323
	
	if event is InputEventMouse:
		var mouseEvent = event.duplicate()
		mouseEvent.position = get_global_transform_with_canvas().affine_inverse() * event.position
		player._unhandled_input(mouseEvent)
	else:
		player._unhandled_input(event)
