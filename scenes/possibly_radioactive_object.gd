class_name PossiblyRadioactiveObject
extends Node3D

var _radioactive_object_data: RadioactiveObject

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


func set_radioactive_object(new_radioactive: RadioactiveObject) -> void:
	_radioactive_object_data = new_radioactive
	if _radioactive_object_data:
		audio_stream_player_3d.stream = _radioactive_object_data.get_audio()
	else:
		audio_stream_player_3d.stream = null
