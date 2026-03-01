extends Node
var show_inventory_menu: bool
var show_pause_menu: bool


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		inventory_menu_pressed()
	elif event.is_action_pressed("pause"):
		pause_menu_pressed()
	else:
		return
func pause_menu_pressed():
	get_tree().paused = !get_tree().paused
	show_pause_menu = get_tree().paused
	show_inventory_menu = false
	
	
	
func inventory_menu_pressed():
	get_tree().paused = !get_tree().paused
	show_inventory_menu = get_tree().paused
	show_pause_menu = false
	
	
