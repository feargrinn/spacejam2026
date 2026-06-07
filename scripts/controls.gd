class_name ControlsPanel
extends PanelContainer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_control_panel"):
		visible = !visible
