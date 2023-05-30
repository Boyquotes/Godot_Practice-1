extends Node

@onready var player = $PlayerStats
@onready var enemy = $Enemy

@onready var swordButton = $UI/GridContainer/SwordButton
@onready var healButton = $UI/GridContainer/HealButton
@onready var blockButton = $UI/GridContainer/BlockButton

class Action:
	var button: Button
	var ap_cost
	var mp_cost
	
	func _init(_button = null, _ap_cost = 0, _mp_cost = 0):
		button = _button
		ap_cost = _ap_cost
		mp_cost = _mp_cost

var ActionList: Array

func _ready():
	ActionList.append(Action.new(swordButton, player.sword_ap_cost, player.sword_mp_cost))
	ActionList.append(Action.new(swordButton, player.sword_ap_cost, player.sword_mp_cost))
	ActionList.append(Action.new(swordButton, player.sword_ap_cost, player.sword_mp_cost))

signal end_turn

func _on_sword_button_pressed():
	if (enemy != null):
		enemy.hp -= player.attack_value
		process_action_cost(player.sword_ap_cost, player.sword_mp_cost)

func _on_heal_button_pressed():
	player.hp += player.heal_value
	process_action_cost(player.heal_ap_cost, player.heal_mp_cost)

func _on_block_button_pressed():
	player.is_blocking = true
	process_action_cost(player.block_ap_cost, player.block_mp_cost)

func process_action_cost(action_cost, magic_cost):
	player.ap -= action_cost
	player.mp -= magic_cost
	
	if (player.ap <= 0):
		swordButton.disabled = true
		healButton.disabled = true
		blockButton.disabled = true
		end_turn.emit()
	
	for action in ActionList:
		if (action.ap_cost > player.ap):
			action.button.disabled = true
		if (action.mp_cost > player.mp):
			action.button.disabled = true

func _on_enemy_end_turn():
	player.is_blocking = false
	player.ap = player.max_ap
	
	swordButton.disabled = false
	healButton.disabled = false
	blockButton.disabled = false

func _on_enemy_died():
	swordButton.disabled = true
	healButton.disabled = true
	blockButton.disabled = true
	enemy = null
