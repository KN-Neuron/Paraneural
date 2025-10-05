extends ProgressBar

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	self.value = randi_range(0, 100)
