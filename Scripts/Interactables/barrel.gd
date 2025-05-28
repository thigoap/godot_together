extends Node2D

@onready var interaction_area = $InteractionArea
@onready var sprite_2d = $Sprite2D

@onready var player_manager = $"../Player Manager"
@onready var p01_inv = $"../Player01/Player Inventory"
@onready var p01_inv_res: Inv = preload('res://Inventory/player01_inventory.tres')
@onready var p02_inv = $"../Player02/Player Inventory"
@onready var p02_inv_res: Inv = preload('res://Inventory/player02_inventory.tres')

@export var loot:InvItem
@export var consumesp1:InvItem
@export var consumesp2:InvItem
@export var full = true

func _ready():
	interaction_area.interact = Callable(self, "_interact")
	if full:
		sprite_2d.frame = 2
	
func _interact():
	var has_fire = _has_fire()
	var has_water = _has_water()
	if (!full):
		if player_manager.player && has_fire:
			print('no water to extinguish the fire.')
		elif player_manager.player && !has_fire:
			print('no fire and no water.')
				
		if !player_manager.player && has_water:
			p02_inv.remove(consumesp2)
			full = true
			sprite_2d.frame = 2
			print('water returned to barrel.')
		elif !player_manager.player && !has_water:
			print('no water.')
		
	else: # if full
		if player_manager.player && !has_fire:
			print('no fire to be extinghuished.')
		elif player_manager.player && has_fire:
			p01_inv.remove(consumesp1)
			full = false
			sprite_2d.frame = 0
			print('fire loot removed.')
			
		if !player_manager.player && has_water:
			print('player 2 already has water.')
		elif !player_manager.player && !has_water:
			p02_inv.collect(loot)
			sprite_2d.frame = 0
			full = false
			print('player 2 collected water.')
			

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
