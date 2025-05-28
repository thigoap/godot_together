# https://www.youtube.com/watch?v=X3J0fSodKgs
extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]

func check(item: InvItem):
	print('checking')
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		print('already have this item.')
		return false
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if emptyslots.is_empty():
		print('inventory is full.')
		return false
	print('true')
	return true

func collect(item: InvItem):
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	emptyslots[0].item = item
	update.emit()
	
func remove(item: InvItem):
	for itemSlot in slots:
		if itemSlot.item == item:
			itemSlot.item = null
	update.emit()
