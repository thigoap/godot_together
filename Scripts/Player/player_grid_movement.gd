# https://www.youtube.com/watch?v=9u1Dq6h7sGU
extends Node2D

@onready var tile_map = $"../../TileMap"
@onready var sprite_2d = $"../PlayerSprite2D"
@onready var animation_player = $"../AnimationPlayer"
@onready var ray_cast_2d = $"../PlayerSprite2D/RayCast2D"

var is_moving = false

func _physics_process(delta):
	if Input.is_action_pressed("swap"):
		animation_player.stop()
		
	if is_moving == false:
		#animation_player.stop()
		return
	
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
		
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		return
	else:
		var direction = ""
		direction = detectDirection()[0]
		if direction == "up":
			move(Vector2.UP)
		elif direction == "down":
			move(Vector2.DOWN)
		elif direction == "left":
			move(Vector2.LEFT)
		elif direction == "right":
			move(Vector2.RIGHT)
		if (direction):
			animation_player.play("walk_"+direction)
		if (!Input.is_anything_pressed()):
			animation_player.stop()
			# animation_player.play("idle_"+direction)
			# print("direction: " + direction)
		

func detectDirection():
	var direction = ""
	var last_direction = ""
	if Input.is_action_pressed("up"):
		direction = "up"
	elif Input.is_action_pressed("down"):
		direction = "down"
	elif Input.is_action_pressed("left"):
		direction= "left"
	elif Input.is_action_pressed("right"):
		direction = "right"
	return [direction, last_direction]

func move(direction: Vector2):
	# Get current tile Vector2i
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	# Get target tile Vector2i
	var target_tile: Vector2i = Vector2i (
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	#prints(current_tile, target_tile)
	# Get custom data layer from the target tile
	var tile_data_l0: TileData = tile_map.get_cell_tile_data(0, target_tile)
	var tile_data_l1: TileData = tile_map.get_cell_tile_data(1, target_tile)
	
	if tile_data_l0 and tile_data_l0.get_custom_data("walkable") == false \
	or tile_data_l1 and tile_data_l1.get_custom_data("walkable") == false:
		return
		
	ray_cast_2d.target_position = direction * 16
	ray_cast_2d.force_raycast_update()
	
	if ray_cast_2d.is_colliding():
		return
	
	# Move player
	is_moving = true
	global_position = tile_map.map_to_local(target_tile)
	sprite_2d.global_position = tile_map.map_to_local(current_tile)
