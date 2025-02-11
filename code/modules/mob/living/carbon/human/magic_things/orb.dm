/area/town
	name = "Inside Town"
	icon_state = "town"
	var/have_magic = TRUE

/obj/machinery/power/smes/orb
	name = "Ядро"
	desc = "То, что даёт нам энергию"
	interact_offline = TRUE
	output_attempt = 1
	outputting = 2

/obj/machinery/power/smes/orb/Initialize()
	..()
	addtimer(new Callback(src, .proc/blackout), 5 SECONDS, TIMER_LOOP)

/obj/machinery/power/smes/orb/proc/blackout()
	var/area/town/T = get_area(src)
	if(charge <= 0)
		T.have_magic = FALSE
	else if (charge > 0 && !T.have_magic)
		T.have_magic = TRUE


/obj/machinery/power/smes/orb/Process()
	if(failure_timer)
		failure_timer--
		return

	if(last_disp != chargedisplay() || last_chrg != inputting || last_onln != outputting)
		update_icon()

	last_disp = chargedisplay()
	last_onln = outputting

	output_used = 0

	//outputting
	if(output_attempt && (!output_pulsed && !output_cut) && powernet && charge)
		output_used = min(charge/CELLRATE, output_level)		//limit output to that stored
		remove_charge(output_used)			// reduce the storage (may be recovered in /restore() if excessive)
		add_avail(output_used)				// add output to powernet (smes side)
		outputting = 2
	else if(!powernet || !charge)
		outputting = 1
	else
		outputting = 0

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
		O.charge += 20
		user.happy -= 10
