extends Node3D

const STANDARD_RADIOACTIVE_OBJECT = preload("uid://bhp30m83703xn")
const PATRYK_RADIOACTIVE_OBJECT = preload("uid://bffhnqe1xgyx0")

@onready var possibly_radioactive_object: PossiblyRadioactiveObject = $PossiblyRadioactiveObject
@onready var possibly_radioactive_object_3: PossiblyRadioactiveObject = $PossiblyRadioactiveObject3
@onready var panel_container: PanelContainer = %PanelContainer
@onready var panel_container_2: PanelContainer = %LoseScreen

func _ready() -> void:
	possibly_radioactive_object.set_radioactive_object(STANDARD_RADIOACTIVE_OBJECT)
	possibly_radioactive_object_3.set_radioactive_object(PATRYK_RADIOACTIVE_OBJECT)
	GroupHandler.group_emptied.connect(_on_group_emptied)
	Player.instance.get_data().lost.connect(panel_container_2.show)


func _on_group_emptied(group: GroupHandler.Group) -> void:
	if group == GroupHandler.Group.BEEPERS:
		panel_container.show()
