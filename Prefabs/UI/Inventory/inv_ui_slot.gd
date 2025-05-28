extends Panel

@onready var item_sprite: Sprite2D = $CenterContainer/Panel/ItemSprite2D

func update(slot: InvSlot):
	if !slot.item:
		item_sprite.visible = false
	else:
		item_sprite.visible = true
		item_sprite.texture = slot.item.texture
