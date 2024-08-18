/mob
	var/max_happy = 5000
	var/happy = 3000


/mob/living/carbon/human/verb/show_happy()
	set name = "Показать радость"
	set category = "IC"

	var/mob/living/carbon/human/H = usr
	to_chat(H, "У меня [H.happy] радости")

/mob/living/carbon/human/verb/verb_steal_happy(mob/target)
	set name = "Украсть радость"
	set category = "IC"

	steal_happy(target)

/mob/living/carbon/human/proc/steal_happy(mob/living/carbon/human/target)
	var/mob/living/carbon/human/H = usr
	var/mob/living/carbon/human/T = target

	if(T == H)
		to_chat(H, "У меня нет цели...")
		return

	while(do_after(H, 5 SECONDS))
		H.happy += 10
		T.happy -= 10
