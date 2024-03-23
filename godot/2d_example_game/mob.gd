extends RigidBody2D

#var animationNames = $AnimatedSprite2D.sprite_frames.get_animation_names()
#var lastAnimationIndex =  animationNames.size() - 1;

func _ready():
	var animationNames = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var lastAnimationIndex =  animationNames.size() - 1;
	$AnimatedSprite2D.play(animationNames[randi_range(0, lastAnimationIndex)])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
