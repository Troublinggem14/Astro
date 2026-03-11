extends Control

@onready var slots = $HBoxContainer.get_children()
@export var player: AstroClassName

var selected_index: int = 0


func _ready():

	update_hotbar()

	InventoryManager.inventory_updated.connect(update_hotbar)

	update_selection()


func _input(event):

	if event.is_action_pressed("hotbar_1"):
		select_slot(0)

	if event.is_action_pressed("hotbar_2"):
		select_slot(1)

	if event.is_action_pressed("hotbar_3"):
		select_slot(2)

	if event.is_action_pressed("hotbar_4"):
		select_slot(3)

	if event.is_action_pressed("hotbar_5"):
		select_slot(4)

	if event.is_action_pressed("hotbar_6"):
		select_slot(5)

	if event.is_action_pressed("scroll_up"):
		scroll_hotbar(-1)

	if event.is_action_pressed("scroll_down"):
		scroll_hotbar(1)


func scroll_hotbar(direction):

	selected_index += direction

	if selected_index < 0:
		selected_index = slots.size() - 1

	if selected_index >= slots.size():
		selected_index = 0

	update_selection()
	held_item()


func select_slot(index):

	selected_index = index
	update_selection()
	held_item()


func update_selection():

	for i in range(slots.size()):

		if i == selected_index:
			slots[i].modulate = Color(1,1,1)
		else:
			slots[i].modulate = Color(0.6,0.6,0.6)


func update_hotbar():

	var inventory_slots = InventoryManager.inventory.slots

	for i in range(slots.size()):

		slots[i].set_slot(inventory_slots[i])

func held_item():

	var slot = InventoryManager.inventory.slots[selected_index]

	if slot.item == null:
		player.current_tool = data_types.Tools.None
		return

	if slot.item.name == "Hoe":
		player.current_tool = data_types.Tools.TillGround
	elif slot.item.name == "Axe":
		player.current_tool = data_types.Tools.AxeWood
	elif slot.item.name == "Pickaxe":
		player.current_tool = data_types.Tools.MineStone
	elif slot.item.name == "Watering Can":
		player.current_tool = data_types.Tools.WaterCrops
	else:
		player.current_tool = data_types.Tools.None
