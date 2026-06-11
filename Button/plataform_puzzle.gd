extends Node2D
 
@onready var platforms = {
	0: $"../TileMapLayer_Red",
	1: $"../TileMapLayer_Orange",
	2: $"../TileMapLayer_Yellow",
	3: $"../TileMapLayer_Green",
	4: $"../TileMapLayer_Blue",
	5: $"../TileMapLayer_Purple",
}
 
@onready var buttons = {
	0: $Buttons/ButtonRed,
	1: $Buttons/ButtonOrange,
	2: $Buttons/ButtonYellow,
	3: $Buttons/ButtonGreen,
	4: $Buttons/ButtonBlue,
	5: $Buttons/ButtonPurple,
}
 
var active_platform_id: int = -1
 
func _ready() -> void:
	# Esconde todas as plataformas no início
	for id in platforms:
		_set_platform_active(id, false)
 
	# Conecta os sinais de todos os botões
	for id in buttons:
		buttons[id].button_activated.connect(_on_button_activated)
		buttons[id].button_deactivated.connect(_on_button_deactivated)
 
func _on_button_activated(color_id: int) -> void:
	# Desativa a plataforma anterior se houver uma ativa
	if active_platform_id != -1:
		_set_platform_active(active_platform_id, false)
 	
	active_platform_id = color_id
	_set_platform_active(color_id, true)
 
func _on_button_deactivated(color_id: int) -> void:
	# Só desativa se for a plataforma atualmente ativa
	if active_platform_id == color_id:
		await get_tree().create_timer(6.0).timeout
		_set_platform_active(color_id, false)
		active_platform_id = -1
 
func _set_platform_active(id: int, active: bool) -> void:
	var platform: TileMapLayer = platforms[id]
	platform.visible = active
	# Ativa/desativa a colisão corretamente no TileMapLayer
	if active:
		platform.collision_enabled = true
	else:
		platform.collision_enabled = false
