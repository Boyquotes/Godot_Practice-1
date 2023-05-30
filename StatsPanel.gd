extends Panel

@onready var hpLabel = $HPLabelNum
@onready var hpAnimPlayer = $HPLabelNum/AnimationPlayer

@onready var apLabel = $HBoxContainer/APLabel
@onready var mpLabel = $HBoxContainer/MPLabel

signal labels_ready

func _on_player_stats_hp_changed(value, damage):
	hpLabel.text = str(value)
	if (damage):
		hpAnimPlayer.queue("Damage")

func _on_player_stats_ap_changed(value):
	apLabel.text = "AP\n" + str(value)

func _on_player_stats_mp_changed(value):
	mpLabel.text = "MP\n" + str(value)

func _on_enemy_attack(damage):
	pass # Replace with function body.

func _ready():
	labels_ready.emit()
