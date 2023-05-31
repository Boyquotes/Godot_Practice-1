extends Panel

enum hp_change_types {
	DAMAGE,
	BLOCKED,
	HEAL
}

@onready var hpLabel = $HPLabelNum
@onready var hpAnimPlayer = $HPLabelNum/AnimationPlayer

@onready var apLabel = $HBoxContainer/APLabel
@onready var mpLabel = $HBoxContainer/MPLabel

signal labels_ready

func _on_player_stats_hp_changed(value, type):
	hpLabel.text = str(value)
	match type:
		hp_change_types.DAMAGE:
			hpAnimPlayer.queue("Damage")
		hp_change_types.BLOCKED:
			hpAnimPlayer.queue("Damage_Blocked")
		hp_change_types.HEAL:
			hpAnimPlayer.queue("Heal")

func _on_player_stats_ap_changed(value):
	apLabel.text = "AP\n" + str(value)

func _on_player_stats_mp_changed(value):
	mpLabel.text = "MP\n" + str(value)

func _ready():
	labels_ready.emit()
