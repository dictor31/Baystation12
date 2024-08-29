/mob/living/carbon/human
	var/max_happy = 5000
	var/happy = 3000


/mob/living/carbon/human/verb/show_happy()
	set name = "Показать радость"
	set category = "IC"

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
		H.happy += 10
		T.happy -= 10


/mob/living/carbon/human/proc/can_steal_happy(mob/living/carbon/human/target)
	var/obj/item/grab/G = src.get_active_hand()
	var/mob/living/carbon/human/H = usr

	if(!target)
		to_chat(H, "У меня нет цели...")
		return FALSE

	if(target.happy < 5)
		to_chat(src, SPAN_WARNING("Эта цель потеряла надежду"))
		return FALSE

	if(!istype(G))
		to_chat(src, SPAN_WARNING("Мне нужно схватить цель"))
		return FALSE

	var/mob/living/carbon/human/T = G.affecting
	if(!istype(T))
		return FALSE

	return TRUE
