class_name LoseScreen
extends PanelContainer

@onready var sub_viewport: SubViewportWithLevel = $"../SubViewportContainer/SubViewport"

func _on_button_pressed() -> void:
	Player.instance.get_data().radiation = 0
	sub_viewport.load_level()
	hide()
