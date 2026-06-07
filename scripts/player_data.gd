class_name PlayerData
extends Resource

signal lost
signal threshold_passed

var current_threshold := 0

@export var thresholds: int = 5
@export var radiation: float = 0.0:
	set(value):
		radiation = value
		changed.emit()
		if value >= max_radiation:
			radiation = value
			lost.emit()
			return
		var threshold_size := max_radiation / (thresholds + 1)
		if radiation > threshold_size * (current_threshold + 1):
			current_threshold += 1
			Panner.turn_on()
			threshold_passed.emit()

@export var max_radiation: float = 1000.0:
	set(value):
		radiation = value
		changed.emit()


func receive_radiation() -> void:
	radiation += 1
