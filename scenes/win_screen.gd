class_name WinScreen
extends PanelContainer

@onready var sub_viewport: SubViewportWithLevel = $"../SubViewportContainer/SubViewport"

func _on_button_pressed() -> void:
	LevelManager.current_level += 1
	sub_viewport.load_level()
	hide()
