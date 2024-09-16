/area/town
	name = "Inside Town"
	icon_state = "town"
	var/have_magic = TRUE

/obj/machinery/power/smes/orb
	name = "Ядро"
	desc = "То, что даёт нам энергию"
	interact_offline = TRUE
	output_attempt = 1
	outputting = 1

/obj/machinery/power/smes/orb/Initialize()
	..()
	addtimer(new Callback(src, .proc/blackout), 10 SECONDS, TIMER_LOOP)

/obj/machinery/power/smes/orb/proc/blackout()
	var/area/town/T = get_area(src)
	if(charge <= 0)
		T.have_magic = FALSE
	else if (charge > 0 && !T.have_magic)
		T.have_magic = TRUE


/obj/machinery/orb_charger
	name = "Машина для зарядки сферы"
	var/obj/machinery/power/smes/orb/O

/obj/machinery/orb_charger/Initialize()
	. = ..()
	for(var/obj/machinery/power/smes/M in world)
		if(istype(M, /obj/machinery/power/smes/orb))
			O = M

/obj/machinery/orb_charger/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(user.happy <= 10)
		to_chat(user, "Мне не хватает для зарядки")
		return
	if(user.mind?.assigned_role != "Высший сборщик")
		to_chat(user, "Я не знаю, что с этим делать")
		return
	if(O.charge >= O.capacity)
		to_chat(user, "Машина полна энергии, она не нуждается в зарядке")
		return

	while(do_after(user, 0.5 SECONDS) && user.happy > 10 && O.charge < O.capacity)
		O.charge += 10
		user.happy -= 10
