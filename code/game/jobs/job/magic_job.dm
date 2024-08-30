/datum/job/collector
	title = "Высший сборщик"
	department = "Neutral"
	department_flag = NEU

	total_positions = 3
	spawn_positions = 3
	supervisors = "Глава поселения"
	outfit_type = /singleton/hierarchy/outfit/collector

/datum/job/junior_medic
	title = "Ученик целителя"
	department = "Medical"
	department_flag = MED

	total_positions = 2
	spawn_positions = 2
	supervisors = "Целитель"
	outfit_type = /singleton/hierarchy/outfit/medic



/datum/job/head_medic
	title = "Целитель"
	department = "Medical"
	department_flag = MED

	total_positions = 1
	spawn_positions = 1
	supervisors = "Глава поселения"
	outfit_type = /singleton/hierarchy/outfit/medic/head
