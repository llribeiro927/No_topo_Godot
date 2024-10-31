extends Area2D

@onready var victory_message = get_node("/root/World/CanvasLayer/VictoryLabel")

func spawn_feedback():
	var scene_to_spawn = preload("res://Pickups/Feedback/feedback.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	new_scene_instance.global_position = global_position


func _on_body_entered(body):
	spawn_feedback()
	queue_free()
	
	end_game()
	
func end_game():
	#   victory_message = get_parent().get_node("CanvasLayer/VictoryLabel")
	if victory_message: 
		victory_message.text = "Parabéns! Você venceu!"  
		victory_message.visible = true  

		#body.set_physics_process(false)  # Pausa o processamento físico do personagem
	else:
		print("Erro: victory_message não está atribuído.")
