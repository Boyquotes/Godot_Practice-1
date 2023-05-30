extends Node

@export_group("Stats")
@export var max_hp = 25
var hp = max_hp:
	set(value):
		var damage = value < hp
		hp = clamp(value, 0, max_hp)
		hp_changed.emit(hp, damage)
signal hp_changed(value, damage)

@export var max_ap = 3
var ap = max_ap:
	set(value):
		ap = clamp(value, 0, max_ap)
		ap_changed.emit(ap)
signal ap_changed(value)

@export var max_mp = 10
var mp = max_mp:
	set(value):
		mp = clamp(value, 0, max_mp)
		mp_changed.emit(mp)
signal mp_changed(value)

@export_group("Attack")
@export var attack_value = 4
@export var sword_ap_cost = 1
@export var sword_mp_cost = 0

@export_group("Heal")
@export var heal_value = 10
@export var heal_ap_cost = 2
@export var heal_mp_cost = 4

@export_group("Block")
@export var block_value = 4
@export var block_ap_cost = 1
@export var block_mp_cost = 0

var is_blocking = false

#Signals
func _on_enemy_attack(value):
	if (is_blocking):
		hp -= floor(value/2)
	else:
		hp -= value

func _on_stats_panel_labels_ready():
	hp_changed.emit(hp, false)
	ap_changed.emit(ap)
	mp_changed.emit(mp)
