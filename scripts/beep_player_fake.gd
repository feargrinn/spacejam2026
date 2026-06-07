# Do not use this class. Sad. Pathetic. Kózka sounds.
class_name BeepPlayerFake
extends AudioStreamPlayer

const HANDLED_GROUP := GroupHandler.Group.BEEPERS

@export var handled_radiation_type: RadioactiveObject.RadiationTypeEnum

@onready var player := Player.instance

var _my_beepers: Array[PossiblyRadioactiveObject]


func _ready() -> void:
	GroupHandler.node_added_to_group.connect(_on_node_added_to_group)
	GroupHandler.node_removed_from_group.connect(_on_node_removed_from_group)


func _to_be_handled(node: Node, group: GroupHandler.Group) -> bool:
	if not group == HANDLED_GROUP:
		return false
	if not node is PossiblyRadioactiveObject:
		return false
	var possibly_radioactive := node as PossiblyRadioactiveObject
	if not possibly_radioactive.is_radioactive():
		return false
	if not possibly_radioactive.get_radiation_type_enum() == handled_radiation_type:
		return false
	return true


func _on_node_added_to_group(node: Node, group: GroupHandler.Group) -> void:
	if not _to_be_handled(node, group):
		return
	var possibly_radioactive := node as PossiblyRadioactiveObject
	_my_beepers.append(possibly_radioactive)


func _on_node_removed_from_group(node: Node, group: GroupHandler.Group) -> void:
	if not _to_be_handled(node, group):
		return
	var possibly_radioactive := node as PossiblyRadioactiveObject
	_my_beepers.remove_at(_my_beepers.find(possibly_radioactive))


func _time_to_next_beep() -> float:
	var cumulative_frequency := 0.0
	for beeper: PossiblyRadioactiveObject in _my_beepers:
		var distance: float = player.global_position.distance_to(beeper.global_position)
		cumulative_frequency += beeper.get_radioactive_data().calculate_beep_frequency(distance)
	return 1.0 / cumulative_frequency
