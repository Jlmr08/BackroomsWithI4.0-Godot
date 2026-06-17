class_name EntityAI extends CharacterBody3D

@export var Agent: NavigationAgent3D = null
var Speed: float = 5
var __target__: Node3D = null

func _ready() -> void:
	Agent.connect("target_reached", __on_target_reached__)

func SetTarget(Target: Node3D) -> void:
	__target__ = Target

func _physics_process(_Delta: float) -> void:
	if (__target__ != null):
		var destination = Agent.get_next_path_position()
		var directionToDestination = destination - global_position
		var direction = directionToDestination.normalized()
		
		velocity = direction * Speed
		move_and_slide()

func __on_target_reached__() -> void:
	print("Target reached.")
