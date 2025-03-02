/mob
	var/list/cast_spell_bar = list()

/mob/proc/get_knowledge_spells()
	var/assigned_mob = mind.assigned_job

	if(istype(assigned_mob, /datum/job/collector))
		mind?.learned_spells = list(
		new /spell/targeted/projectile/dumbfire/fireball,
		new /spell/targeted/projectile/magic_missile,
		new /spell/targeted/projectile/dumbfire/passage,
		new /spell/aoe_turf/blink,
		new /spell/aoe_turf/conjure/forcewall,
		new /spell/invisibility,
		new /spell/aoe_turf/smoke,
		new /spell/targeted/swap,
		new /spell/targeted/ethereal_jaunt,
		new /spell/targeted/genetic/blind
		)


/spell/targeted/projectile/dumbfire/fireball
	name = "Огненный шар"
	desc = "Классическое заклинание разрушительного огненного шара"
	cast_combo = list(I_HURT, I_HURT)
	cost_charge = 300

/spell/aoe_turf/blink
	name = "Скачок"
	desc = "Заклинание телепортации, что случайно телепортирует на короткую дистанцию"
	cast_combo = list(I_DISARM)
	cost_charge = 100

/spell/targeted/projectile/dumbfire/passage
	name = "Прыжок"
	desc = "Заклинание телепортации, что телепортирует к той точке, об которую ударился снаряд"
	cast_combo = list(I_GRAB, I_HELP)
	cost_charge = 200

/spell/aoe_turf/conjure/forcewall
	name = "Барьер"
	desc = "Создает непробиваемый барьер, который может проходить насквозь только создатель"
	cast_combo = list(I_HELP)

/spell/aoe_turf/smoke
	name = "Дымовая завеса"
	desc = "Создаёт густое облако дыма, которое скрывает создателя"
	cast_combo = list(I_HELP, I_HELP)

/spell/invisibility
	name = "Невидимость"
	desc = "Делает тебя незримым"
	cast_combo = list(I_DISARM, I_DISARM)

/spell/targeted/swap
	name = "Измена"
	desc = "Меняет местами тебя и случайного человека поблизости"
	cast_combo = list(I_HELP, I_HELP, I_HELP)

/spell/targeted/ethereal_jaunt
	name = "Форма духа"
	desc = "Даёт тебе на несколько секунд стать нематериальным"
	cast_combo = list(I_DISARM, I_DISARM, I_DISARM)

/spell/targeted/ethereal_jaunt/shift
	name = "Форма духа"
	desc = "Особая форма духа, для последователей Крови"
	cast_combo = list(I_GRAB, I_GRAB)

/spell/targeted/genetic/blind
	name = "Ослепление"
	desc = "Это заклинание ослепит всех, кто видит твоё величие"
	cast_combo = list(I_GRAB, I_GRAB, I_GRAB)

/spell/targeted/projectile/dumbfire/stuncuff
	name = "Связывание"
	desc = "Заклинание даёт возможность задержать преступника"
	cast_combo = list(I_GRAB)
