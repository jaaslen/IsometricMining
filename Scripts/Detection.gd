extends TileMapLayer
@onready var detector

signal StartedMiningAnim


var ModFactor = [0.05,0.05,0.05]

@onready var Cursor = self.get_node("Cursor")
@onready var Effects = self.get_node("Effects")
var InMine = true
var ToSurface = false
var MovingBetween = false
var Locked = false
var ShiftLocked = false
var Mining = false
var MovingDown = false

var MovingSideways = Vector2(0,0)

var TileCoords = [Vector2i(-1,-1),Vector2i(-2,0),Vector2i(0,-1),
Vector2i(-3,1),Vector2i(-1,0),Vector2i(1,-1),
Vector2i(-2,1),Vector2i(0,0),Vector2i(-1,1)]

var DefaultPos = []
var TargetPos = []#[-Global.Tile_Size.y,0,Global.Tile_Size.y,68,102,136,170,204]
#var Global.Tiles = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,1,0],[0,0,0,0,0,0,0,1,0],[1,1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	
	tile_set.tile_size = Global.TileSize

	for i in range(20):
		DefaultPos.append(i * Global.TileSize.y)# + Global.TileSize.y/2)
		TargetPos.append((i-1) * Global.TileSize.y)# + Global.TileSize.y/2)
	
	
	var timer := Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_tick)
	add_child(timer)
	
	
	
	var index = 0
	for layer in self.get_node("Layers").get_children():
		layer.modulate = Color(1 - (index) * ModFactor[0],1 - (index) * ModFactor[1],1 - (index) * ModFactor[2])
		layer.z_index = self.get_node("Layers").get_child_count() - index
		index += 1
		
	ResetLayers()
		
	pass # Replace with function body.

  #*# (pow(1.5, log(Global.Depth + 1) / log(10.0))) * 10)
var Speed = ((100 / Global.Pickaxe["stats"][1]))
@onready var Layer1 = self.get_node("Layers").get_node("1")
func _process(delta: float) -> void:
	if MovingDown == true:
		Speed = ((100 / Global.Pickaxe["stats"][1]))
		var index = 0
		for layer in self.get_node("Layers").get_children():
 #layer.modulate.lerp(Color(1 - (index-1) * ModFactor[0],1 - (index-1) * ModFactor[1],1 - (index-1) * ModFactor[2]),delta* Speed / 80)
			if index == 0:
				
				layer.scale = layer.scale.lerp(Vector2.ZERO,delta*max(Speed,100) / 30)
				layer.position -= Vector2(0,delta* Speed)
				var posy = layer.position.y
				layer.modulate = Color(1 - (ModFactor[0] * (posy/Global.TileSize.y)),1 - (ModFactor[0] * (posy/Global.TileSize.y)),1 - (ModFactor[0] * (posy/Global.TileSize.y)))
				if Speed >= 1000:
					layer.visible = false
					#layer.position += Vector2(0,-delta * Speed)#layer.position.lerp(Vector2(0,TargetPos[index]),delta * Speed)
				else:
					pass
			else:
				
				layer.position += Vector2(0,-delta * Speed)
				
				var posy = layer.position.y
				var mod = 1 - (ModFactor[0] * ((posy)/Global.TileSize.y))
				layer.modulate = Color(mod,mod,mod)
				#layer.position = layer.position.lerp(Vector2(0,TargetPos[index]),delta * Speed / 10)
				#var layernum = index 
			index += 1
		index = 0
		var layer = self.get_node("Layers").get_node("1")
		#if equal_approx(layer.position, (Vector2(0,TargetPos[index])),3) :
		var distance = -(Vector2(0,TargetPos[index]) - layer.position)
		
		if distance.y < 1:
			
			ResetLayers()

			
			MovingDown = false
		#elif distance.y < 8:
			#Speed = ((150 / Global.Pickaxe["stats"][1]))

	elif MovingBetween == true:
		var shift = 1
		if ToSurface == true:
			shift = 10
		
		var index = 0
		for layer in self.get_node("Layers").get_children():
			layer.position = layer.position.lerp(Vector2(0,TargetPos[index+shift]),delta * 5)
		
			#if index == 0:
				#layer.scale = layer.scale.lerp(Vector2.ZERO,delta * 10)
			#else:
				#var layernum = index 
			index += 1
		index = 0
		var layer = self.get_node("Layers").get_node("1")
		#if equal_approx(layer.position, (Vector2(0,TargetPos[index])),3) :
		var distance = layer.position.distance_to((Vector2(0,TargetPos[index+shift])))

		
		if equal_approx(layer.position, (Vector2(0,TargetPos[index+shift])),0.1):
			if ToSurface == false:
				for layers in self.get_node("Layers").get_children():
					#layers.modulate = Color(1 - (index) * ModFactor[0],1 - (index) * ModFactor[1],1 - (index) * ModFactor[2])
					layers.position = Vector2i(0,DefaultPos[str_to_var(layers.name)-1])
					layers.scale = Vector2(1,1)
			Speed = Global.Pickaxe[1] #/ (pow(1.5, log(Global.Depth + 1) / log(10.0))) * 6
			MovingBetween = false

		else:
			if distance > 1:
				pass
				#Speed = Global.Pickaxe[1] / (pow(1.5, log(Global.Depth + 1) / log(10.0))) * (30 / (max(distance,1)/5))
			pass

	elif MovingSideways != Vector2(0,0):
		for layer in self.get_node("Layers").get_children():
			Speed = ((150 / Global.Pickaxe["stats"][1]))
			layer.position += Vector2( Global.CellSize.x * delta* Speed / 80,Global.CellSize.y * delta* Speed / 80) * MovingSideways

			if MovingSideways.y * (Vector2(Global.CellSize)-Layer1.position).y < 0 :
				ResetSideLayer()



#func _input(Input: InputInput) -> void:
#func _physics_process(delta: float) -> void:
	##(Vector2(floor(mousepos.x / Global.CellSize.x) , floor(mousepos.y / Global.CellSize.y)))
	if Input.is_action_just_pressed("LockShift") and InMine == true:
		if ShiftLocked == false:
			for i in Effects.get_children():
				if i.name != "Mining":
					i.call_deferred("queue_free")
			ShiftLocked = true
			Locked = false
		else:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			ShiftLocked = false
			for i in Effects.get_children():
				if i.name != "Mining":
					i.call_deferred("queue_free")
		
	
	elif Input.is_action_just_pressed("Shift") and InMine == true and MovingDown == false and Mining == false and MovingSideways == Vector2(0,0) and Locked == false :
		MovingSideways = Vector2(1,1)
		#Layer1.erase_cell(Vector2i(-1,2))
		#Layer1.erase_cell(Vector2i(0,1))
		#Layer1.erase_cell(Vector2i(1,0))
		#Layer1.erase_cell(Vector2i(2,-1))
		#Layer1.erase_cell(Vector2i(3,-2))
		#Layer1.erase_cell(Vector2i(2,-2))
		for layer in self.get_node("Layers").get_children():
			layer.erase_cell(Vector2i(1,-1))
			layer.erase_cell(Vector2i(0,0))
			layer.erase_cell(Vector2i(-1,1))
		#Layer1.erase_cell(Vector2i(-2,2))
		
		
		
	elif Input.is_action_just_pressed("Lock") and InMine == true:
		if Locked == false:
			for i in Effects.get_children():
				if i.name != "Mining":
					i.call_deferred("queue_free")
			Locked = true
			ShiftLocked = false
		else:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Locked = false
			for i in Effects.get_children():
				if i.name != "Mining":
					i.call_deferred("queue_free")
		#
		pass
	


	var pos = GetMouse() + Vector2(Global.CellSize.x / 2, Global.CellSize.y / 2)
	
	if Input.is_action_just_pressed("MoveDown") and MovingDown == false and MovingBetween == false and Mining == false and MovingSideways == Vector2(0,0):
		#MoveBetween()
		MoveDown()
		pass
	
	if ((Input.is_action_just_pressed("Mine") and InMine == true and MovingBetween == false) or Locked == true or ShiftLocked == true) and MovingDown == false and MovingSideways == Vector2(0,0):
		
		#var pos = get_global_mouse_position() + Vector2(Global.CellSize.x / 2, Global.CellSize.y / 2)
		
		var coordinates = [Vector2i(0,-2),Vector2i(-1,-1),Vector2i(1,-1),Vector2i(-2,0),Vector2i(0,0),Vector2i(2,0),Vector2i(-1,1),Vector2i(1,1),Vector2i(0,2)]
		
		
		for layer in self.get_node("Layers").get_children():
			#print(Vector2i(int(floor(pos.x / Global.CellSize.x)),int(floor(pos.y / Global.CellSize.y)) - int(str_to_var(layer.name)-1) ))
			if Cursor.OnGrid or Locked == true or ShiftLocked == true:
				#for offset in [Vector2i(-1,0),Vector2i(0,0),Vector2i(0,0),Vector2i(0,0),Vector2i(0,0)]
				##(layer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1)) != -1)
				#if str_to_var(layer.name) > 1:
					#pass
				
				if layer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1)) != -1:
					
					var previouslayer = self.get_node("Layers").get_child(str_to_var(layer.name)-1-1)
					##(previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1)) == -1 or str_to_var(layer.name) == 1)
					#(previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(1,0)) + previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(-1,1)))
					if previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1)) == -1 and previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(1,0)) + previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(-1,1)) or str_to_var(layer.name) == 1 : 
						#if Mining == false:
							MineTile(layer)
							
							if str_to_var(layer.name) == 1:
								for coords in TileCoords: 
									if layer.get_cell_source_id(coords) != -1:
										#z#(previouslayer.get_cell_source_id(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1-1)))
										
										return
										
							
							return
						
					else:
						
						
						
					
					
					##(layer)
					
						return
				else:
					pass
		
				
func MoveDown():
	
	Global.GlobalMoveDown()
	MovingDown = true
	for i in TargetPos:
		i += Global.TileSize.y

		
func MoveDownFullCheck():
	if Global.TopLayer[4] == -1:
		MoveDown()

func ResetSideLayer():
	var index = 0
	for layer in self.get_node("Layers").get_children():
		layer.position = Vector2i(0,DefaultPos[index])
		var newlayer
		if layer.name == "1":
			
			#Global.TopLayer = [0,0,0,0,0,0,0,0,0]
			newlayer = Global.TopLayer
				
		else:
			newlayer = Global.Tiles[str_to_var(layer.name)-2]
			#Global.Tiles[str_to_var(layer.name)-2] = []
		#if MovingSideways == Vector2(1,1):
		var MoveInfo = [[Vector2(2,-1),Vector2(1,0),Vector2(0,1)],[TileCoords[5],TileCoords[7],TileCoords[8]]]
		#var Index = 0
		#for coords in [Vector2(2,-1),Vector2(1,0),Vector2(0,1)]:
			#if Index == 0:
				#var TileAtlas = layer.get_cell_atlas_coords(TileCoords[5])
				#layer.set_cell(coords,0,TileAtlas)
			#elif Index == 1:
				#var TileAtlas = layer.get_cell_atlas_coords(TileCoords[7])
				#layer.set_cell(coords,0,TileAtlas)
			#elif Index == 2:
				#var TileAtlas = layer.get_cell_atlas_coords(TileCoords[8])
				#layer.set_cell(coords,0,TileAtlas)
			#Index += 1
		var Index = 0
		for coords in [TileCoords[5],TileCoords[7],TileCoords[8]]:
			if Index == 0:
				#var OreID
				
				
				newlayer[5] = newlayer[2]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[2])
				layer.set_cell(coords,0,TileAtlas)
			elif Index == 1:
				
				newlayer[7] = newlayer[4]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[4])
				layer.set_cell(coords,0,TileAtlas)
			elif Index == 2:
				
				newlayer[8] = newlayer[6]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[6])
				layer.set_cell(coords,0,TileAtlas)
			Index += 1
		
		Index = 0
		for coords in [TileCoords[2],TileCoords[4],TileCoords[6]]:
			if Index == 0:
				newlayer[2] = newlayer[0]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[0])
				layer.set_cell(coords,0,TileAtlas)
			elif Index == 1:
				newlayer[4] = newlayer[1]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[1])
				layer.set_cell(coords,0,TileAtlas)
			elif Index == 2:
				newlayer[6] = newlayer[3]
				var TileAtlas = layer.get_cell_atlas_coords(TileCoords[3])
				layer.set_cell(coords,0,TileAtlas)
			Index += 1
			
		#Index = 0
		#for coords in [TileCoords[0],TileCoords[1],TileCoords[3]]:
			#if Index == 0:
				#var TileAtlas = layer.get_cell_atlas_coords(Vector2i(-2,-1))
				#layer.set_cell(coords,0,TileAtlas)
			#elif Index == 1:f
				#var TileAtlas = layer.get_cell_atlas_coords(Vector2i(-3,0))
				#layer.set_cell(coords,0,TileAtlas)
			#elif Index == 2:
				#var TileAtlas = layer.get_cell_atlas_coords(Vector2i(-4,1))
				#layer.set_cell(coords,0,TileAtlas)
			#Index += 1
			
		Index = 0

		var finds = [0,1,3]
		for coords in [TileCoords[0],TileCoords[1],TileCoords[3]]:
			
				var Tile = Global.GenerateOre(str_to_var(layer.name) -1 - 7)
				#if layer.name == "1":
					#Global.TopLayer[finds[Index]] = Tile
				#else:
				newlayer[finds[Index]] = Tile
				var TileAtlas
				if Tile == 1:
					TileAtlas = Global.Layer["atlas"]
					if layer.get_cell_atlas_coords(coords) != Vector2i(TileAtlas[0],TileAtlas[1]):
						layer.set_cell(coords,0,Vector2i(TileAtlas[0],TileAtlas[1]))#Global.GameData["ores"][str(Tile)]["id"])
				else:
					TileAtlas = Global.GameData["ores"][str(Tile)]["atlas"]
				layer.set_cell(coords,0,Vector2i(TileAtlas[0],TileAtlas[1]))
				Index+=1
		index += 1
	MovingSideways = Vector2(0,0)
			
		
func ResetLayers():

	Global.GlobalLayerChange()

	var index = 0
	for layer in self.get_node("Layers").get_children():
		layer.modulate = Color(1 - (index) * ModFactor[0],1 - (index) * ModFactor[1],1 - (index) * ModFactor[2])
		layer.position = Vector2i(0,DefaultPos[index])
		layer.scale = Vector2(1,1)
		layer.visible = true
		
		var tileindex = 0
		for coords in TileCoords:
			layer.erase_cell(coords)
			var Tile = Global.Tiles[index][tileindex]
			if Tile != -1 and Tile != 1:
				var TileAtlas = Global.GameData["ores"][str(Tile)]["atlas"]
				if layer.get_cell_atlas_coords(coords) != Vector2i(TileAtlas[0],TileAtlas[1]):
					layer.set_cell(coords,0,Vector2i(TileAtlas[0],TileAtlas[1]))#Global.GameData["ores"][str(Tile)]["id"])
			elif Tile == 1:
				var TileAtlas = Global.Layer["atlas"]
				if layer.get_cell_atlas_coords(coords) != Vector2i(TileAtlas[0],TileAtlas[1]):
					layer.set_cell(coords,0,Vector2i(TileAtlas[0],TileAtlas[1]))#Global.GameData["ores"][str(Tile)]["id"])
			else:
				layer.erase_cell(coords)
			tileindex += 1
			
		index += 1
	Global.PreviousTopLayer = Global.TopLayer
	Global.TopLayer = Global.Tiles[0]
	Global.Tiles.remove_at(0)
	
	var newlayer = []
	#if Locked == true and Global.Pickaxe["stats"][1] < 0.2:
		#newlayer = [1,1,1,1,Global.GenerateOre(),1,1,1,1]
	#else:
	for i in range(9):
		newlayer.append(Global.GenerateOre())

		
	
	#(newlayer)
	Global.Tiles.append(newlayer)
	MovingDown = false
	
	pass

func _on_tick():
	pass
	##([Global.Tiles[0]],[Global.Tiles[1]],[Global.Tiles[2]])

func equal_approx(a,b,c) -> bool:
	return a.distance_to(b) < c
	
func MineTile(layer,shift = Vector2i.ZERO):
	Mining = true
	#round(Cursor.position)# 
	
	
	var GlobalCoordinates = Vector2(round(GetMouse().x / Global.CellSize.x) * Global.CellSize.x,round(GetMouse().y / Global.CellSize.y) * Global.CellSize.y)#GetMouse() #- Vector2(0,str_to_var(layer.name)-1) * Vector2(Global.TileSize)
	var Coordinates = local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1)
	

	#MiningAnim(Coordinates,GlobalCoordinates,layer)
	
	
	
	var OreID = -1 #Global.Tiles[str_to_var(layer.name) -2][TileCoords.find(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1))]
	
	if str_to_var(layer.name) - 1 > 0:
		OreID = Global.Tiles[str_to_var(layer.name) -2][TileCoords.find(local_to_map(GetMouse()) - Vector2i(0,str_to_var(layer.name)-1))]
		
		
	if str_to_var(layer.name) == 1:
		OreID = Global.TopLayer[TileCoords.find(local_to_map(GetMouse()))]
		
		
		
	MiningAnim(Coordinates,Cursor.position,layer,OreID)
		
	pass
	
func MiningAnim(TileCoordinates,MouseCoordinates,Layer,OreID):
		if Locked == false and ShiftLocked == false:
			emit_signal("StartedMiningAnim",0,0)
			for i in Effects.get_children():
				if i.name != "Mining":
					i.call_deferred("queue_free")
					
	
		var BottomBlocked = false
		var TopLeftBlocked = false
		var TopRightBlocked = false
		
		var LeftVisible = true
		var RightVisible = true
		
		
		if str_to_var(Layer.name) > 1:
			if self.get_node("Layers").get_child(str_to_var(Layer.name)-2).get_cell_source_id(TileCoordinates + Vector2i(-1,1)) != -1:
				#("TopLeft Blocked")
				TopLeftBlocked = true
			if self.get_node("Layers").get_child(str_to_var(Layer.name)-2).get_cell_source_id(TileCoordinates + Vector2i(1,0)) != -1:
				#("TopRight Blocked")
				TopRightBlocked = true
		
		if Layer.get_cell_source_id(TileCoordinates + Vector2i(-1,1)) != -1:
			#("Block On Left")
			LeftVisible = false
		if Layer.get_cell_source_id(TileCoordinates + Vector2i(1,0)) != -1:
			#("Block On Right")
			RightVisible = false
		if Layer.get_cell_source_id(TileCoordinates + Vector2i(0,1)) != -1:
			#("Block On Bottom")
			BottomBlocked = true
		var TopAnimation
		#("wow")
		if Effects.has_node(var_to_str(TileCoordinates)) == false:
			TopAnimation = Effects.get_node("Mining").duplicate()
		else:
			return
			#TopAnimation = Effects.get_node(var_to_str(TileCoordinates))
		if Locked == false and ShiftLocked == false:
			TopAnimation.position = MouseCoordinates
		elif Locked:
			TopAnimation.position = Vector2(0,0)
		elif ShiftLocked:
			TopAnimation.position = Vector2(32,17)
		#TopAnimation.z_index = self.get_node("Layers").get_child_count() - (str_to_var(Layer.name)-1)
		TopAnimation.visible = true

		
		if LeftVisible == false and RightVisible == false:
			TopAnimation.animation = "Top"
		elif LeftVisible == true and RightVisible == false:
			TopAnimation.animation = "Left"
		elif LeftVisible == false and RightVisible == true:
			TopAnimation.animation = "Right"
		elif LeftVisible == true and RightVisible == true:
			TopAnimation.animation = "Full"
		
		#(TopAnimation.animation)
		#(TopRightBlocked)
		
		if TopLeftBlocked:
			if TopAnimation.animation == "Top":
				TopAnimation.animation = "TopL"
			else:
				TopAnimation.animation = TopAnimation.animation + "T"
				
		if TopRightBlocked == true:
			if TopAnimation.animation == "Top":
				TopAnimation.animation = "TopR"

			else:
				TopAnimation.animation = TopAnimation.animation + "T"
				
		if BottomBlocked:
			if TopAnimation.animation in ["Top","TopL","TopR"]:
				pass
			else:
				TopAnimation.animation = TopAnimation.animation + "B"
		
		
		TopAnimation.name = var_to_str(TileCoordinates)
		
		Effects.call_deferred("add_child", TopAnimation)
		
		var frame_count = TopAnimation.sprite_frames.get_frame_count(TopAnimation.animation)
		var desired_time = (Global.GameData["ores"][var_to_str(OreID)]["hardness"] * (pow(1.5, log(Global.Depth + 1) / log(10.0)))) / ( Global.Pickaxe["stats"][0] )

		TopAnimation.sprite_frames.set_animation_speed(TopAnimation.animation, frame_count / desired_time)
		
		emit_signal("StartedMiningAnim",desired_time,OreID)
		#TopAnimation.speed_scale = ( (3 * Global.Pickaxe["stats"][0] * Global.Pickaxe["stats"][0]) / Global.GameData["ores"][var_to_str(OreID)]["hardness"]) / (pow(1.5, log(Global.Depth + 1) / log(10.0)))
		#print((pow(1.5, log(max(Global.Depth,1)) / log(10.0))))
		if TopAnimation.speed_scale > 10:
			TopAnimation.speed_scale *= 20

		TopAnimation.play()
		TopAnimation.animation_finished.connect(FinishedMining.bind(TopAnimation.name,TileCoordinates,OreID,Layer),CONNECT_ONE_SHOT)
		
		
		
		

func GetMouse():
	if Locked == false and ShiftLocked == false:
			return Cursor.position
	elif Locked:
		return Vector2(0,0)
	elif ShiftLocked:
		return Vector2(32,17)
		
func MoveBetween():
	ToSurface = !ToSurface
	
	if ToSurface == true:
		InMine = false
	else:
		InMine = true
	
	MovingBetween = true
	
	pass
	
func FinishedMining(AnimName,TileCoordinates,OreID,Layer):
	var TopAnimation = Effects.get_node(str(AnimName))
	TopAnimation.call_deferred("queue_free")
	Layer.erase_cell(TileCoordinates)
	Mining = false
	if str_to_var(Layer.name) == 1:
		Global.TopLayer[TileCoords.find(TileCoordinates)] = -1
	else:
		Global.Tiles[str_to_var(Layer.name) -2][TileCoords.find(TileCoordinates)] = -1
	
	Global.AddOre(OreID)
	Global.GainXP( Global.GameData["ores"][var_to_str(OreID)]["xp"] )
	MoveDownFullCheck()
	if ShiftLocked == true:
		MovingSideways = Vector2(1,1)
		for layer in self.get_node("Layers").get_children():
				layer.erase_cell(Vector2i(1,-1))
				layer.erase_cell(Vector2i(0,0))
				layer.erase_cell(Vector2i(-1,1))
	pass
