extends Node2D

@onready var door = $"."
@onready var interaction_area = $InteractionArea
@onready var sprite_2d = $Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var player_manager = $"../Player Manager"
@onready var p01_inv: Inv = preload('res://Inventory/player01_inventory.tres')
@onready var p02_inv: Inv = preload('res://Inventory/player02_inventory.tres')

var opened = false
var locked = true

func _ready():
	# door.set_collision_layer_value(3, true)
	interaction_area.interact = Callable(self, "_open_close")
	
func _open_close():
	# sprite_2d.frame = 2 if sprite_2d.frame == 0 else 0
	if (!opened):
		var has_key = _has_key()
		if has_key or !locked:
			animation_player.play("door_open")
			opened = true
			locked = false
			# remove door colision layer
			# door.set_collision_layer_value(3, false)
		else:
			print('player does not have the key')
	else:
		animation_player.play("door_close")
		opened = false
		# door.set_collision_layer_value(3, true)

func _has_key():
	for i in range (2):
		var inventory_slot
		if player_manager.player:
			inventory_slot = p01_inv.slots[i].item
		else:
			inventory_slot = p02_inv.slots[i].item
		if inventory_slot && inventory_slot.name == 'key':
			return true
	return false
