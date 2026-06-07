class_name RadioactiveObject
extends Resource

enum RadiationTypeEnum {
	STANDARD,
}

static var radiation_resource_by_type: Dictionary[RadiationTypeEnum, RadiatonType] = {
	RadiationTypeEnum.STANDARD : preload("res://resources/standard_radiation.tres"),
}

@export var radiation_type: RadiationTypeEnum
@export var beep_frequency: float = 10 # beeps per second

var radiation_res: RadiatonType


func _init() -> void:
	radiation_res = radiation_resource_by_type[radiation_type]


func get_audio() -> AudioStream:
	return radiation_res.audio_file


func calculate_beep_frequency(distance: float) -> float:
	# Sure lets assume that this is linear for now
	var divider := distance * radiation_res.falloff
	return beep_frequency / divider


func calculate_time_to_beep(distance: float) -> float:
	return 1.0 / calculate_beep_frequency(distance)


func randomised_beep_time(distance: float) -> float:
	const RANDOM_FACTOR = 0.3
	var base_time_to_beep := calculate_time_to_beep(distance)
	return base_time_to_beep * randf_range(1.0 - RANDOM_FACTOR, 1.0 + RANDOM_FACTOR)
