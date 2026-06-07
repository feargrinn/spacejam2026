class_name LoseScreen
extends PanelContainer


func _on_button_pressed() -> void:
	Player.instance.get_data().radiation = 0
	get_tree().reload_current_scene()
