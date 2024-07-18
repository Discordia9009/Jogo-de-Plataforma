extends Node2D

const Wait_Duration = 1.0
@onready var platform := $PlatForm2 as AnimatableBody2D
@export var Move_SPeed := 6
@export var distance := 300
@export var Move_Horizontal = true 

var follow = Vector2.ZERO
var Platform_center = 16

func _ready():
	Move_Platform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	platform.position = platform.position.lerp(follow, 0.5)

func Move_Platform():
	var move_direction = Vector2.RIGHT * distance if Move_Horizontal else Vector2.UP * distance
	
	var duration = move_direction.length() / float(Move_SPeed * Platform_center)
	
	var Platform_Tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	Platform_Tween.tween_property(self, "follow", move_direction, duration).set_delay(Wait_Duration)
	Platform_Tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(Wait_Duration + 3)
	
