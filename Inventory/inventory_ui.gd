extends Control

@onready var slots = $GridContainer.get_children()


func _ready():

	update_inventory()

	InventoryManager.inventory_updated.connect(update_inventory)


func update_inventory():

	var inventory_slots = InventoryManager.inventory.slots

	for i in range(slots.size()):

		slots[i].set_slot(inventory_slots[i])
