extends Node3D

const ROT_SPEED = 2 # deg of coins rotates every frame
@export var hud : CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))


func _on_area_3d_body_entered(_body: Node3D) -> void:
	Global.coins += 1
	print(Global.coins)
	hud.get_node("TextureRect/CoinsLabel").text = str(Global.coins)
	if Global.coins >= Global.NUM_COINS_TO_WIN:
		get_tree().change_scene_to_file("res://level_1.tscn")
	$Area3D.set_collision_layer_value(3, false)
	$Area3D.set_collision_mask_value(1, false)
	$Area3D/AnimationPlayer.play("bounce")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
