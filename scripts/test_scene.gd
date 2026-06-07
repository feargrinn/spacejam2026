extends Node3D

const STANDARD_RADIOACTIVE_OBJECT = preload("uid://bhp30m83703xn")

@onready var possibly_radioactive_object: PossiblyRadioactiveObject = $PossiblyRadioactiveObject
@onready var possibly_radioactive_object_3: PossiblyRadioactiveObject = $PossiblyRadioactiveObject3

func _ready() -> void:
	possibly_radioactive_object.set_radioactive_object(STANDARD_RADIOACTIVE_OBJECT)
	possibly_radioactive_object_3.set_radioactive_object(STANDARD_RADIOACTIVE_OBJECT)
