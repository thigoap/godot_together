extends Node2D

@onready var interaction_area = $InteractionArea
@onready var sprite_2d = $Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var player_manager = $"../Player Manager"
@onready var p01_inv = $"../Player01/Player Inventory"
@onready var p01_inv_res: Inv = preload('res://Inventory/player01_inventory.tres')
@onready var p02_inv = $"../Player02/Player Inventory"
@onready var p02_inv_res: Inv = preload('res://Inventory/player02_inventory.tres')

@export var loot:InvItem
@export var consumes:InvItem
@export var lit = true

func _ready():
	interaction_area.interact = Callable(self, "_interact")
	if lit:
		animation_player.play("torch_burning")
	
func _interact():
	var has_fire = _has_fire()
	var has_water = _has_water()
	if (!lit):
		if player_manager.player && has_fire:
			p01_inv.remove(loot)
			lit = true
			animation_player.play("fire_on")
			animation_player.queue("torch_burning")
			print('torch lit.')
		elif player_manager.player && !has_fire:
			print('player 1 does not have fire.')
			
		if !player_manager.player && has_water:
			print('there is no fire to extinguish.')
		elif !player_manager.player && !has_water:
			print('no fire and no water.')
		
	else: # if lit
		if player_manager.player && !has_fire:
			p01_inv.collect(loot)
			# extinghuishes fire if taken from torch
			# lit = false
			# animation_player.play("fire_off")
			print('player 1 collected fire.')
		elif player_manager.player && has_fire:
			print('player 1 already has fire.')
			
		if !player_manager.player && has_water:
			p02_inv.remove(consumes)
			lit = false
			animation_player.play("fire_off")
			print('fire extinguished.')
		elif !player_manager.player && !has_water:
			print('player 2 does not have water to extinguish the fire.')

func _has_fire():
	for i in range (2):
		var inventory_slot
		if player_manager.player:
			inventory_slot = p01_inv_res.slots[i].item
			if inventory_slot && inventory_slot.name == 'fire':
				return true
	return false
	
func _has_water():
	for i in range (2):
		var inventory_slot
		if !player_manager.player:
			inventory_slot = p02_inv_res.slots[i].item
			if inventory_slot && inventory_slot.name == 'water':
				return true
	return false
