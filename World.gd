extends Node2D

const PLAYERSPEED = 250
const INITBALLSPEED = 100

var screenSize
var padSize 
var ballDirection = Vector2(1.0,0.0)
var ballSpeed = INITBALLSPEED


func _ready():
	screenSize = get_viewport_rect().size
	padSize = get_node("rightPlayer").get_texture().get_size()
	set_process(true)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#ball Position 
	var ballPosition = get_node("ball").position
	
	#Colliders
	var leftCollider = Rect2(get_node("leftPlayer").position - padSize*0.5,padSize )
	var rightCollider = Rect2(get_node("rightPlayer").position - padSize*0.5,padSize )
	
	#Player postions 
	var rightPlayerPosition = get_node("rightPlayer").position.y
	var leftPlayerPosition = get_node("leftPlayer").position.y
	
	# check if right player has pressed a button.
	if( rightPlayerPosition >0 and Input.is_action_just_pressed("ui_up")):
		rightPlayerPosition += -PLAYERSPEED * delta
	if(rightPlayerPosition < screenSize.y and Input.is_action_just_pressed("ui_down")):
		rightPlayerPosition += PLAYERSPEED * delta	
		
	# check if left player has pressed a button
	if(leftPlayerPosition >0 and Input.is_action_just_pressed("left_up")):
		leftPlayerPosition += -PLAYERSPEED * delta
	if(leftPlayerPosition < screenSize.y and Input.is_action_just_pressed("left_down")):
		leftPlayerPosition += PLAYERSPEED * delta	
	
	ballPosition += ballDirection * ballSpeed * delta
	if ((ballPosition.y <0 and ballDirection< 0 ) and (ballPosition.y > screenSize.y and ballDirection.y > 0 )):
		ballDirection.y = -ballDirection.y 
	if(leftCollider.has_point(ballPosition) or rightCollider.has_point(ballPosition)):
			ballDirection.x = -ballDirection.x
			ballDirection.y = randf()*2 -1 
			ballDirection = ballDirection.normalized()
			if(ballSpeed<300):
				ballSpeed *= 1.4
	
	if(ballPosition.x < 0 ):
		ballPosition = screenSize * 0.5
		ballSpeed = INITBALLSPEED
	if(ballPosition.x > screenSize.x):
		ballPosition = screenSize * 0.5
		ballSpeed = INITBALLSPEED

	#update player positions
	get_node("leftPlayer").position.y = leftPlayerPosition
	get_node("rightPlayer").position.y= rightPlayerPosition
	get_node("ball").position = ballPosition
