class_name PossiblyRadioactiveObject
extends Node3D

var _radioactive_object_data: RadioactiveObject
var sarcophagi_count := 0
var sarcophagi: Array[MeshInstance3D]

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var interactible: Interactible = $Interactible
@onready var mesh_instance_3d: MeshInstance3D = $StaticBody3D/MeshInstance3D


func _ready() -> void:
	interactible.sarcophagused.connect(sarcophaguse)


func set_radioactive_object(new_radioactive: RadioactiveObject) -> void:
	_radioactive_object_data = new_radioactive
	if is_radioactive():
		audio_stream_player_3d.stream = _radioactive_object_data.get_audio()
	else:
		audio_stream_player_3d.stream = null


func is_radioactive() -> bool:
	return _radioactive_object_data != null

func sarcophaguse() -> void:
	var new_mesh := mesh_instance_3d.duplicate()
	add_child(new_mesh)
	new_mesh.global_position = mesh_instance_3d.global_position
	new_mesh.global_basis = mesh_instance_3d.global_basis
	sarcophagi_count += 1
	for i in range(sarcophagi_count):
		new_mesh.scale *= 1.1;
	sarcophagi.append(new_mesh)
