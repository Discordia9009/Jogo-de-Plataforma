extends Control

@onready var clock_timer = $Clock_Timer as Timer
var totaltimes:int = 0
@onready var label = $Label
@onready var player = $"../../Player"
@export var changer_area:Area2D

func _ready():
	changer_area.connect("PlayerStopped", PauseTimer)
	changer_area.connect("PlayerMove", StartTimer)

func _on_clock_timer_timeout():
	totaltimes += 1
	var m = int(totaltimes / 60.0)
	var s = totaltimes - m * 60
	label.text = "%02d:%02d" % [m, s]
	

func PauseTimer():
	clock_timer.stop()
	

func StartTimer():
	if clock_timer.is_stopped():
		clock_timer.start()
