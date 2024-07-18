extends Area2D

@export var Pcam1:PhantomCamera2D
@export var Pcam2:PhantomCamera2D
@onready var player = $"../../Player"
var PlayerStarts = 1
signal PlayerStopped
signal PlayerMove

func _ready():
	self.body_entered.connect(PlayerEnter)
	self.body_exited.connect(PlayerExitted)
	

func PlayerEnter(body):
	if PlayerStarts > 1:
		player.set_physics_process(false)
		emit_signal("PlayerStopped")
	CamChangScript.CameraChanger(Pcam2, Pcam1, false)
	if Pcam2.tween_completed:
		await get_tree().create_timer(1.00).timeout
		player.set_physics_process(true)
		emit_signal("PlayerMove")
	

func PlayerExitted(body):
	PlayerStarts += 1
	player.set_physics_process(false)
	emit_signal("PlayerStopped")
	CamChangScript.CameraChanger(Pcam1, Pcam2, false)
	if Pcam1.tween_completed:
		await get_tree().create_timer(1.00).timeout
		player.set_physics_process(true)
		emit_signal("PlayerMove")
		
