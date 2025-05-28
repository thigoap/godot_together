# https://www.youtube.com/watch?v=ajCraxGAeYU
extends Node2D

#@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label
@onready var player_manager = $"../Player Manager"

const base_text = '[E] to '

var active_areas = ['','']
var can_interact = true


func register_area(area: InteractionArea, actor: String):
	#prints('manager: ', actor)
	if actor == 'Player01Area2D':
		active_areas[0] = area
	elif actor == 'Player02Area2D':
		active_areas[1] = area
	#print(active_areas)
	
func unregister_area(area: InteractionArea, actor: String):
	if actor == 'Player01Area2D':
		active_areas[0] = ''
	elif actor == 'Player02Area2D':
		active_areas[1] = ''
	#print(active_areas)


func _input(event):
	if event.is_action_pressed('interact') && can_interact:
		if (player_manager.player && active_areas[0]):
			can_interact = false
			await active_areas[0].interact.call()
			can_interact = true
		elif (!player_manager.player && active_areas[1]):
			can_interact = false
			await active_areas[1].interact.call()
			can_interact = true


func _process(delta):
	if active_areas.size() > 0 && can_interact:
		pass
		# label.text = base_text + active_areas[0].action_name
		# label.global_position = active_areas[0].global_position
		# label.global_position.y -= 36
		# label.global_position.x -= label.size.x / 2
		# label.show()
	else:
		pass
		# label.hide()
