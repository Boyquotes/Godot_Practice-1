extends Node2D

@onready var hpLabel = $HPLabel
@onready var animationPlayer = $AnimationPlayer
@onready var audioPlayer = $AudioStreamPlayer2D

@export var attack_damage = 4
@export var impact_timestamp = 0.6
@export var max_hp = 25
var hp = max_hp:
	get:
		return hp
	set(value):
		if (value < hp):
			if (value <= 0):
				die()
			else:
				hp = max(0, value)
				hpLabel.text = str(hp)
				animationPlayer.play("Shake")

signal died
signal attack(damage)
signal end_turn

func die():
	died.emit()
	animationPlayer.queue("Death")
	await animationPlayer.animation_finished
	queue_free()

func _ready():
	hpLabel.text = str(hp)

func _on_battle_end_turn():
	if (animationPlayer.is_playing()):
		await animationPlayer.animation_finished
	animationPlayer.queue("Attack")
	await get_tree().create_timer(impact_timestamp).timeout
	audioPlayer.play()
	attack.emit(attack_damage)
	await animationPlayer.animation_finished
	end_turn.emit()
