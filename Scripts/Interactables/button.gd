extends Node2D

@onready var sprite_2d = $Sprite2D
@export var activate:Area2D


func _on_area_entered(area):
	sprite_2d.frame = 1 if sprite_2d.frame == 0 else 0
	#activate.set_collision_mask_value(1, false)
	#activate.set_collision_mask_value(2, false)
	activate.set_collision_layer_value(4, false)
	#activate.get_node("Sprite2D").frame = 2 if sprite_2d.frame == 3 else 3
	activate.animation_player.play('spikes_hide')


func _on_area_exited(area):
	sprite_2d.frame = 0 if sprite_2d.frame == 1 else 1
	#activate.set_collision_mask_value(1, true)
	#activate.set_collision_mask_value(2, true)
	activate.set_collision_layer_value(4, true)
	#activate.get_node("Sprite2D").frame = 3 if sprite_2d.frame == 2 else 2
	activate.animation_player.play('spikes_show')
	activate.check_player()
