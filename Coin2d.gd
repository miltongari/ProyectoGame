extends Area2D


func _on_Coin2d_body_entered(body):
	queue_free()

