extends CharacterBody2D

@onready var ghost_timer = $GhostTimer
const NormalSpeed = 400.0
var CanJump = true
var JumpBuffer = false
const JUMP_VELOCITY = -500.0
var gravity = 900.0
var ScaleSprite = Vector2(0.093, 0.094)
@onready var SpritePlayer = $Sprite2D
@onready var DashTimere = $DashTimer
@export var Coyote_Time: float = 0.1
@export var Jump_Buffer_Time: float = .1
@export var PlayerStopped:bool = false
@export var Ghost_Node:PackedScene
const DashSpeed = 1000
const DashLeght = .1
var PlayAnimation = false
var ColdDown = true

func _physics_process(delta):
#region Movimentacao
	var direction = Input.get_axis("Left", "Rigth")
	var SPEED = DashSpeed if IsDashing() else NormalSpeed
	
	if Input.is_action_just_pressed("Dash") and ColdDown == true:
		StartDash(DashLeght)
		ghost_timer.start()
		ColdDown = false
		
	
	self.velocity.y += gravity * delta
	if not is_on_floor():
		if CanJump:
			get_tree().create_timer(Coyote_Time).timeout.connect(Coyote_TimeOut)
	else:
		CanJump = true
		if JumpBuffer:
			Jump()
			JumpBuffer = false

	if Input.is_action_just_pressed("Jump"):
		if CanJump:
			Jump()
		else:
			JumpBuffer = true
			get_tree().create_timer(Jump_Buffer_Time).timeout.connect(on_jump_buffer_timeout)


	
	if direction:
		velocity.x = direction * SPEED
		SpritePlayer.flip_h = direction == -1 if true else false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
#endregion



func StartDash(Duration):
	DashTimere.wait_time = Duration
	DashTimere.start()


func IsDashing():
	return !DashTimere.is_stopped()


func _on_area_2d_body_entered(body):
	if body:
		body.position = Vector2(32, 497)

func DashDelay():
	if DashTimere.wait_time != 0:
		await get_tree().create_timer(1.00).timeout
		


func _on_area_2d_2_body_entered(body):
	var Animation_Player = body.get_node("AnimationPlayer")
	if body.is_in_group("PlatForms") and Animation_Player.assigned_animation != "ColorAnimation":
		Animation_Player.play("ColorAnimation")


func _on_dash_timer_timeout():
	await get_tree().create_timer(1.00).timeout
	ColdDown = true
	

func Jump():
	velocity.y = JUMP_VELOCITY
	CanJump = false

func Coyote_TimeOut():
	CanJump = false

func on_jump_buffer_timeout():
	JumpBuffer = false

func Add_Ghost():
	var Ghost = Ghost_Node.instantiate()
	Ghost.Set_Property(position, ScaleSprite)
	get_tree().current_scene.add_child(Ghost)

func _on_ghost_timer_timeout():
	if ColdDown == false:
		Add_Ghost()
		await get_tree().create_timer(0.2).timeout
		ghost_timer.stop()
