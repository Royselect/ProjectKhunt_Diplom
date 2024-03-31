extends CharacterBody3D

var target_position = Vector3()

#Проверяем, было ли совершенно прикосновение и сохраняем позицию касания
func _input(event):
	if event is InputEventMouseButton and event.pressed: # Проверяем, было ли нажатие кнопки мыши
		var camera = $"../main/Camera3D" # Получаем ссылку на камеру
		var ray_from = camera.project_ray_origin(event.position) # Получаем начальную точку луча из камеры
		var ray_dir = camera.project_ray_normal(event.position) # Получаем направление луча из камеры
		var space_state = get_world_3d().direct_space_state # Получаем состояние мирового пространства
		var result = space_state.intersect_ray(ray_from, ray_from + ray_dir * 1000) # Пускаем луч и ищем пересечение со сценой
		if result: # Проверяем, было ли найдено пересечение
			target_position = result.position # Устанавливаем новую целевую позицию для перемещения игрока
			target_position.y = 0 # Устанавливаем y координату на уровне земли



func _physics_process(delta):
	var player_position = global_position
	if target_position != Vector3():
		var direction = (target_position - player_position).normalized()
		var new_pos = player_position + direction * 5 * delta
		global_position = new_pos
		if player_position.distance_to(target_position) < 1.0:
			target_position = Vector3()
