extends CharacterBody2D

@onready var animation_player = $"AnimationPlayer"
@onready var animation_effects = $"AnimationEffects"
@onready var hurt_Timer = $"hurtTimer"

const max_speed: int = 120
const acceleration: int = 5
const friction: int = 8

func _ready():
	animation_effects.play("RESET")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("swap"):
		animation_player.stop()
		
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	if input:
	# if input and not GameManager.paused:
		animation_player.speed_scale = (velocity/max_speed).distance_to(Vector2.ZERO) + 0.5
		if Input.is_action_pressed("up"):
			animation_player.play("walk_up")
		elif Input.is_action_pressed("down"):
			animation_player.play("walk_down")
		elif Input.is_action_pressed("left"):
			animation_player.play("walk_left")
		elif Input.is_action_pressed("right"):
			animation_player.play("walk_right")
	else:
		animation_player.speed_scale = 0.75
		animation_player.play("idle_down")

	var lerp_weight = delta * (acceleration if input else friction)
	velocity = lerp(velocity, input * max_speed, lerp_weight)

	move_and_slide()


func _on_hurt_box_area_entered(area):
	knockback()
	animation_effects.play("hurt_blink")
	hurt_Timer.start()
	await hurt_Timer.timeout
	animation_effects.play("RESET")
	
func knockback():
	var knockback_power:int = 150
	var knockback_direction = -velocity.normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide()
