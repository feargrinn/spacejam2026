class_name PlayerData
extends Resource

signal lost

@export var radiation: float = 0.0:
	set(value):
		radiation = value
		changed.emit()
		if radiation >= max_radiation:
			lost.emit()

@export var max_radiation: float = 1000.0:
	set(value):
		radiation = value
		changed.emit()


func receive_radiation() -> void:
	radiation += 1
