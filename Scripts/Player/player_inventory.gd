extends Node

@export var inv:Inv

func check(item):
	if inv.check(item):
		return true

func collect(item):
	inv.collect(item)

func remove(item):
	inv.remove(item)
