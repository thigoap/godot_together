extends Area2D
class_name InteractionArea

@export var action_name:String = "interact"
@onready var interaction_manager = $"../../Interaction Manager"

var interact:Callable = func():
	pass


func _on_area_entered(area):
	# prints(area.name, 'activated interaction area')
	interaction_manager.register_area(self, area.name)
	
func _on_area_exited(area):
	interaction_manager.unregister_area(self, area.name)
