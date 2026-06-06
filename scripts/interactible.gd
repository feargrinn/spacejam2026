class_name Interactible
extends Area3D

signal sarcophagused

func _init() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.tried_interacting.connect(handle_interaction)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.tried_interacting.disconnect(handle_interaction)


func handle_interaction() -> void:
	sarcophagused.emit()
