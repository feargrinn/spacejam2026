class_name RadiationCounter
extends VBoxContainer

var player_data: PlayerData

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	player_data = Player.instance.get_data()
	player_data.changed.connect(_update_progress_bar)


func _update_progress_bar() -> void:
	progress_bar.max_value = player_data.max_radiation
	progress_bar.value = player_data.radiation
