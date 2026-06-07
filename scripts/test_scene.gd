class_name SubViewportWithLevel
extends SubViewport

const STANDARD_RADIOACTIVE_OBJECT = preload("uid://bhp30m83703xn")
const PATRYK_RADIOACTIVE_OBJECT = preload("uid://bffhnqe1xgyx0")

@onready var panel_container: PanelContainer = %PanelContainer
@onready var panel_container_2: PanelContainer = %LoseScreen
@onready var test_scene: Node3D = $TestScene

func _ready() -> void:
	GroupHandler.group_emptied.connect(_on_group_emptied)
	Player.instance.get_data().lost.connect(panel_container_2.show)
	load_level()


func load_level() -> void:
	Player.instance.reparent(self)
	var child = get_child(0)
	remove_child(child)
	child.queue_free()
	var new_level := LevelManager.levels[LevelManager.current_level].instantiate()
	var new_player = new_level.find_child("*Player")
	Player.instance.reparent(new_player.get_parent())
	Player.instance.position = new_player.position
	new_player.get_parent().remove_child(new_player)
	new_player.queue_free()
	add_child(new_level)


func _on_group_emptied(group: GroupHandler.Group) -> void:
	if group == GroupHandler.Group.BEEPERS:
		panel_container.show()
