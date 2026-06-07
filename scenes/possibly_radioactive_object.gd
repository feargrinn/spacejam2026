class_name PossiblyRadioactiveObject
extends Node3D

const BEEPERS: StringName = "beepers"

@export var _radioactive_object_data: RadioactiveObject
var sarcophagi_count := 0
var sarcophagi: Array[MeshInstance3D]
var _is_covered := false

@onready var interactible: Interactible = $Interactible
@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D
@onready var beep_player: AudioStreamPlayer = $BeepPlayer
@onready var beep_time: Timer = $BeepTime

@onready var player := Player.instance


func _ready() -> void:
	interactible.sarcophagused.connect(sarcophaguse)
	beep_time.timeout.connect(_on_beep_timer_timeout)
	_start_beep_timer()
	if (is_radioactive()):
		if ! self in get_tree().get_nodes_in_group("beepers"):
			GroupHandler.add_node_to_group(self, GroupHandler.Group.BEEPERS)


func _get_distance_to_player() -> float:
	return player.global_position.distance_to(self.global_position)


func _start_beep_timer() -> void:
	if not is_radioactive():
		return
	var ttb := _radioactive_object_data.randomised_beep_time(_get_distance_to_player())
	beep_time.start(ttb)


func _on_beep_timer_timeout() -> void:
	_start_beep_timer()
	player.get_data().receive_radiation()
	beep_player.play()


func set_radioactive_object(new_radioactive: RadioactiveObject) -> void:
	if is_radioactive():
		GroupHandler.remove_node_from_group(self, GroupHandler.Group.BEEPERS)
	_radioactive_object_data = new_radioactive
	if is_radioactive():
		GroupHandler.add_node_to_group(self, GroupHandler.Group.BEEPERS)
		beep_player.stream = _radioactive_object_data.get_audio()
		_start_beep_timer()


func is_radioactive() -> bool:
	if _radioactive_object_data == null:
		return false
	return !_is_covered


func get_radioactive_data() -> RadioactiveObject:
	return _radioactive_object_data


func get_radiation_type_enum() -> RadioactiveObject.RadiationTypeEnum:
	return _radioactive_object_data.radiation_type


func stop_radioactivity() -> void:
	_is_covered = true
	beep_time.stop()
	GroupHandler.remove_node_from_group(self, GroupHandler.Group.BEEPERS)


func sarcophaguse() -> void:
	var new_mesh := mesh_instance_3d.duplicate()
	add_child(new_mesh)
	new_mesh.global_position = mesh_instance_3d.global_position
	new_mesh.global_basis = mesh_instance_3d.global_basis
	new_mesh.show()
	sarcophagi_count += 1
	stop_radioactivity()
	for i in range(sarcophagi_count):
		new_mesh.scale *= 1.1;
	sarcophagi.append(new_mesh)
