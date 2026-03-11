extends Sprite2D

@export var item_data: ItemData
@export var quantity: int = 1


func _on_body_entered(body):
	InventoryManager.add_item(item_data, quantity)
	queue_free()
