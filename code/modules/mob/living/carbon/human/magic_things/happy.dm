
/mob/living/carbon/human/proc/switch_happy(value)
	happy += value
	if(happy > max_happy)
		happy = max_happy
	if(happy < 0)
		happy = 0


/mob/living/carbon/human
	var/max_happy = 1000
	var/happy = 500


/mob/verb/show_happy()
	set name = "Показать радость"
	set category = "IC"
	set hidden = 1

	var/mob/living/carbon/human/H = usr
	to_chat(H, "У меня [H.happy] радости")

/mob/living/carbon/human/verb/verb_steal_happy()
	set name = "Украсть радость"
	set category = "IC"

	var/obj/item/grab/G = src.get_active_hand()

	if(!istype(G))
		to_chat(src, SPAN_WARNING("Мне нужно схватить цель, которая еще не потеряла надежду"))
		return

	var/mob/living/carbon/human/T = G.affecting

	steal_happy(T)

/mob/living/carbon/human/proc/steal_happy(mob/living/carbon/human/target)
	var/mob/living/carbon/human/H = usr
	var/mob/living/carbon/human/T = target

	if(!can_steal_happy(T))
		return

	while(do_after(H, 0.5 SECONDS) && can_steal_happy(T))
		var/how_much = rand(1, 10)
		H.happy += how_much
		T.happy -= how_much


/mob/living/carbon/human/proc/can_steal_happy(mob/living/carbon/human/target)
	var/obj/item/grab/G = src.get_active_hand()

	if(!target)
		to_chat(src, SPAN_WARNING("У меня нет цели"))
		return FALSE

	if(target.happy < 10)
		to_chat(src, SPAN_WARNING("Эта цель потеряла надежду"))
		return FALSE

	if(!istype(G))
		to_chat(src, SPAN_WARNING("Мне нужно схватить цель"))
		return FALSE

	var/mob/living/carbon/human/T = G.affecting
	if(!istype(T))
		return FALSE

	return TRUE
