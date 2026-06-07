extends Node

var turned_on := false
var speed := 1.0
const PANNER_IDX := 3
const PAN_EFFECT_IDX := 0
var panner: AudioEffectPanner
var time_to_loop := 3.0
var time := 0.0


func _ready() -> void:
	panner = AudioServer.get_bus_effect(PANNER_IDX, PAN_EFFECT_IDX)


func _process(delta: float) -> void:
	if !turned_on:
		return
	time += delta
	var angle := time / time_to_loop * 2 * PI
	panner.pan = sin(angle)


func turn_on() -> void:
	turned_on = true


func turn_off() -> void:
	turned_on = false
