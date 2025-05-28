extends Node

var player = true
@onready var player_movement_01 = $"../Player01"
@onready var player_movement_02 = $"../Player02"
@onready var animation_player_01 = $"../Player01/AnimationPlayer"
@onready var animation_player_02 = $"../Player02/AnimationPlayer"

#@onready var player_actions_01 = $"../Player01/PlayerActions"
#@onready var player_actions_02 = $"../Player02/PlayerActions"

@onready var inv_avatar_slot = $"../Inventory/GridContainer00/Inv_Avatar_slot"
@onready var inv_avatar_slot2 = $"../Inventory/GridContainer00/Inv_Avatar_slot2"
@onready var grid_container_01 = $"../Inventory/GridContainer01"
@onready var grid_container_02 = $"../Inventory/GridContainer02"

# Called when the node enters the scene tree for the first time.
func _ready():
	player_movement_01.set_process(player)
	player_movement_01.set_physics_process(player)
	player_movement_02.set_process(!player)
	player_movement_02.set_physics_process(!player)
	#player_actions_01.set_process(player)
	#player_actions_01.set_physics_process(player)
	#player_actions_02.set_process(!player)
	#player_actions_02.set_physics_process(!player)
	
	print('player 01') if player else print('player 02')

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("swap"):
		swapPlayer()
	
func swapPlayer():
	player = !player
	player_movement_01.set_process(player)
	player_movement_01.set_physics_process(player)
	player_movement_02.set_process(!player)
	player_movement_02.set_physics_process(!player)
	#player_actions_01.set_process(player)
	#player_actions_01.set_physics_process(player)
	#player_actions_02.set_process(!player)
	#player_actions_02.set_physics_process(!player)
	if player:
		animation_player_02.play("idle_down")
		inv_avatar_slot.modulate.a = 1
		inv_avatar_slot2.modulate.a = 0.25
		grid_container_01.modulate.a = 1
		grid_container_02.modulate.a = 0.25
	else:
		animation_player_01.play("idle_down")
		inv_avatar_slot.modulate.a = 0.25
		inv_avatar_slot2.modulate.a = 1
		grid_container_01.modulate.a = 0.25
		grid_container_02.modulate.a = 1
		
	print('player 01') if player else print('player 02')
