class_name RadioactiveObject
extends Resource

enum RadiationTypeEnum {
	STANDARD,
}

static var radiation_resource_by_type: Dictionary[RadiationTypeEnum, RadiatonType] = {
	RadiationTypeEnum.STANDARD : preload("res://resources/standard_radiation.tres"),
}

@export var radiation_type: RadiationTypeEnum


func get_audio() -> AudioStream:
	return radiation_resource_by_type[radiation_type].audio_file
