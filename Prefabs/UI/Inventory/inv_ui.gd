extends Control

@onready var p01_inv: Inv = preload('res://Inventory/player01_inventory.tres')
@onready var p02_inv: Inv = preload('res://Inventory/player02_inventory.tres')
@onready var p01_slots: Array = $GridContainer01.get_children()
@onready var p02_slots: Array = $GridContainer02.get_children()


func _ready():
	#p01_inv.connect("update", update_slots)
	p01_inv.update.connect(update_slots)
	p02_inv.update.connect(update_slots)
	update_slots()

func update_slots():
	for i in range (min(p01_inv.slots.size(), p01_slots.size())):
		p01_slots[i].update(p01_inv.slots[i])
	for i in range (min(p02_inv.slots.size(), p02_slots.size())):
		p02_slots[i].update(p02_inv.slots[i])
