extends Area2D

@onready var canvas_layer = get_parent().get_parent().get_node("CanvasLayer")
@export var next_level:String = ""

func _ready():
	self.body_entered.connect(Player_In_Side)


func Player_In_Side(body):
	if body.name == "Player" and !next_level == "":
		canvas_layer.Change_Scene(next_level)
	else:
		print("No scene Loaded")
