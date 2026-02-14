extends Sprite2D

@export var smooth_speed := 20

@onready var TileSize = Global.TileSize * (self.get_parent().scale.x / 2)
@onready var CellSize = Global.CellSize * (self.get_parent().scale.x / 2)

var move_timer := 0.0
var grid_pos := Vector2.ZERO
enum movestates {MOUSE, KEYBOARD}
var state = movestates.MOUSE
var OnGrid : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	



	
func _process(delta):
	#var coordinates = snap_to_grid(get_global_mouse_position()) 
	#if int(coordinates.x + coordinates.y) % 2 != 9:
		#if coordinates == Vector2(0,3):
			#texture.region = Rect2(0,0,64,68)
		#elif coordinates in [Vector2(-1,2),Vector2(-2,1)]:
			#texture.region = Rect2(64,0,64,68)
		#elif coordinates in [Vector2(1,2),Vector2(2,1)]:
			#texture.region = Rect2(128,0,64,68)
		#if coordinates.x in [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]:
			#texture.region = Rect2(192,0,64,68)
		#elif coordinates.x == 0:
			#texture.region = Rect2(0,68,64,68)
		#elif coordinates.x < 0:
			#texture.region = Rect2(64,68,64,68)
		#elif coordinates.x > 0:
			#texture.region = Rect2(128,68,64,68)
	#else:
		#texture.region = Rect2(188,16,4,4)
	if state == movestates.MOUSE:
		var mouse_pos := get_global_mouse_position() #+ Vector2(CellSize.x, CellSize.y)
		var snappedtogrid := (snap_to_grid(mouse_pos) * Vector2(TileSize)) + Vector2(CellSize.x, CellSize.y)
		global_position = global_position.lerp(snappedtogrid, smooth_speed * delta)
	if (roundi(position.x / 32) + roundi(position.y / 17)) % 2 == 0:
		OnGrid = true
		#modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		#modulate - Color(1.0, 0.0, 0.0, 1.0)
		OnGrid = false

func snap_to_grid(pos: Vector2) -> Vector2:
	return Vector2(floor(pos.x / TileSize.x),floor(pos.y / TileSize.y)) #+ Vector2(CellSize.x / 2, CellSize.y / 2)
	
func _input(event):
	
	if event is InputEventMouseMotion:
		if state == movestates.KEYBOARD:
			Input.warp_mouse(get_viewport().get_canvas_transform() * global_position)
		state = movestates.MOUSE
		Global.UsingMouse = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pass
	
	
	elif event.is_action_pressed("Left"):
		#get_viewport().warp_mouse(get_viewport().get_mouse_position() + Vector2(-CellSize,0))
		#Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(-CellSize,0))
		global_position += Vector2(-TileSize.x,0)
		state = movestates.KEYBOARD
		#Input.warp_mouse(get_viewport().get_canvas_transform() * global_position)
		Global.UsingMouse = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	elif event.is_action_pressed("Right"):
		#Input.warp_mouse(get_viewport_rect().position)
		#Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(CellSize,0))
		global_position += Vector2(TileSize.x,0)
		state = movestates.KEYBOARD
		Global.UsingMouse = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#Input.warp_mouse(get_viewport().get_canvas_transform() * global_position)
	elif event.is_action_pressed("Up"):
		#Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0,-TileSize))
		global_position += Vector2(0,-TileSize.y)
		state = movestates.KEYBOARD
		Global.UsingMouse = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#Input.warp_mouse(get_viewport().get_canvas_transform() * global_position)
	elif event.is_action_pressed("Down"):
		#Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0,TileSize))
		global_position += Vector2(0,TileSize.y)
		state = movestates.KEYBOARD
		Global.UsingMouse = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#Input.warp_mouse(get_viewport().get_canvas_transform() * global_position)
		

		
