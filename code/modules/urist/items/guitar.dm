//copy pasta of the violin, don't hurt me -Nien

/obj/item/device/guitar
	name = "guitar"
	desc = "It's made of wood and has bronze strings."
	icon = 'icons/urist/items/tools.dmi'
	icon_state = "guitar"
	item_state = "guitar"
	item_icons = DEF_URIST_INHANDS
	force = 10
	attack_verb = list("played metal on", "serenaded", "crashed", "smashed")
	var/datum/song/song
	var/playing = 0
	var/help = 0
	var/edit = 1
	var/repeat = 0

/obj/item/device/guitar/proc/playnote(var/note as text)
	//world << "Note: [note]"
	var/soundfile
	/*BYOND loads resource files at compile time if they are ''. This means you can't really manipulate them dynamically.
	Tried doing it dynamically at first but its more trouble than its worth. Would have saved many lines tho.*/
	switch(note)


		if("En3")	soundfile = 'sound/urist/guitar/En3.ogg'
		if("E#3")	soundfile = 'sound/urist/guitar/Fb3.ogg'
		if("Fb3")	soundfile = 'sound/urist/guitar/Fb3.ogg'
		if("Fn3")	soundfile = 'sound/urist/guitar/Fn3.ogg'
		if("F#3")	soundfile = 'sound/urist/guitar/Gb3.ogg'
		if("Gb3")	soundfile = 'sound/urist/guitar/Gb3.ogg'
		if("Gn3")	soundfile = 'sound/urist/guitar/Gn3.ogg'
		if("G#3")	soundfile = 'sound/urist/guitar/Ab3.ogg'
		if("Ab3")	soundfile = 'sound/urist/guitar/Ab3.ogg'
		if("An3")	soundfile = 'sound/urist/guitar/An3.ogg'
		if("A#3")	soundfile = 'sound/urist/guitar/Bb3.ogg'
		if("Bb3")	soundfile = 'sound/urist/guitar/Bb3.ogg'
		if("Bn3")	soundfile = 'sound/urist/guitar/Bn3.ogg'
		if("B#4")	soundfile = 'sound/urist/guitar/Cb4.ogg'
		if("Cb4")	soundfile = 'sound/urist/guitar/Cb4.ogg'
		if("Cn4")	soundfile = 'sound/urist/guitar/Cn4.ogg'
		if("C#4")	soundfile = 'sound/urist/guitar/Db4.ogg'
		if("Db4")	soundfile = 'sound/urist/guitar/Db4.ogg'
		if("Dn4")	soundfile = 'sound/urist/guitar/Dn4.ogg'
		if("D#4")	soundfile = 'sound/urist/guitar/Eb4.ogg'
		if("Eb4")	soundfile = 'sound/urist/guitar/Eb4.ogg'
		if("En4")	soundfile = 'sound/urist/guitar/En4.ogg'
		if("E#4")	soundfile = 'sound/urist/guitar/Fb4.ogg'
		if("Fb4")	soundfile = 'sound/urist/guitar/Fb4.ogg'
		if("Fn4")	soundfile = 'sound/urist/guitar/Fn4.ogg'
		if("F#4")	soundfile = 'sound/urist/guitar/Gb4.ogg'
		if("Gb4")	soundfile = 'sound/urist/guitar/Gb4.ogg'
		if("Gn4")	soundfile = 'sound/urist/guitar/Gn4.ogg'
		if("G#4")	soundfile = 'sound/urist/guitar/Ab4.ogg'
		if("Ab4")	soundfile = 'sound/urist/guitar/Ab4.ogg'
		if("An4")	soundfile = 'sound/urist/guitar/An4.ogg'
		if("A#4")	soundfile = 'sound/urist/guitar/Bb4.ogg'
		if("Bb4")	soundfile = 'sound/urist/guitar/Bb4.ogg'
		if("Bn4")	soundfile = 'sound/urist/guitar/Bn4.ogg'
		if("B#4")	soundfile = 'sound/urist/guitar/Cb4.ogg'
		if("Cb4")	soundfile = 'sound/urist/guitar/Cb4.ogg'
		if("Cn4")	soundfile = 'sound/urist/guitar/Cn4.ogg'
		if("C#4")	soundfile = 'sound/urist/guitar/Db4.ogg'
		if("Db4")	soundfile = 'sound/urist/guitar/Db4.ogg'
		if("Dn4")	soundfile = 'sound/urist/guitar/Dn4.ogg'
		if("D#4")	soundfile = 'sound/urist/guitar/Eb4.ogg'
		if("Eb4")	soundfile = 'sound/urist/guitar/Eb4.ogg'
		if("En5")	soundfile = 'sound/urist/guitar/En5.ogg'
		if("E#5")	soundfile = 'sound/urist/guitar/Fb5.ogg'
		if("Fb5")	soundfile = 'sound/urist/guitar/Fb5.ogg'
		if("Fn5")	soundfile = 'sound/urist/guitar/Fn5.ogg'
		if("F#5")	soundfile = 'sound/urist/guitar/Gb5.ogg'
		if("Gb5")	soundfile = 'sound/urist/guitar/Gb5.ogg'
		if("Gn5")	soundfile = 'sound/urist/guitar/Gn5.ogg'
		if("G#5")	soundfile = 'sound/urist/guitar/Ab5.ogg'
		if("Ab5")	soundfile = 'sound/urist/guitar/Ab5.ogg'
		if("An5")	soundfile = 'sound/urist/guitar/An5.ogg'
		if("A#5")	soundfile = 'sound/urist/guitar/Bb5.ogg'
		if("Bb5")	soundfile = 'sound/urist/guitar/Bb5.ogg'
		if("Bn5")	soundfile = 'sound/urist/guitar/Bn5.ogg'
		if("B#5")	soundfile = 'sound/urist/guitar/Cb5.ogg'
		if("Cb5")	soundfile = 'sound/urist/guitar/Cb5.ogg'
		if("Cn5")	soundfile = 'sound/urist/guitar/Cn5.ogg'
		if("C#5")	soundfile = 'sound/urist/guitar/Db5.ogg'
		if("Db5")	soundfile = 'sound/urist/guitar/Db5.ogg'
		if("Dn5")	soundfile = 'sound/urist/guitar/Dn5.ogg'
		if("D#5")	soundfile = 'sound/urist/guitar/Eb5.ogg'
		if("Eb5")	soundfile = 'sound/urist/guitar/Eb5.ogg'
		if("En6")	soundfile = 'sound/urist/guitar/En6.ogg'
		if("E#6")	soundfile = 'sound/urist/guitar/Fb6.ogg'
		if("Fb6")	soundfile = 'sound/urist/guitar/Fb6.ogg'
		if("Fn6")	soundfile = 'sound/urist/guitar/Fn6.ogg'
		if("F#6")	soundfile = 'sound/urist/guitar/Gb6.ogg'
		if("Gb6")	soundfile = 'sound/urist/guitar/Gb6.ogg'
		if("Gn6")	soundfile = 'sound/urist/guitar/Gn6.ogg'
		if("G#6")	soundfile = 'sound/urist/guitar/Ab6.ogg'
		if("Ab6")	soundfile = 'sound/urist/guitar/Ab6.ogg'
		if("An6")	soundfile = 'sound/urist/guitar/An6.ogg'
		if("A#6")	soundfile = 'sound/urist/guitar/Bb6.ogg'
		if("Bb6")	soundfile = 'sound/urist/guitar/Bb6.ogg'
		if("Bn6")	soundfile = 'sound/urist/guitar/Bn6.ogg'
		if("B#6")	soundfile = 'sound/urist/guitar/Cb7.ogg'
		if("Cb7")	soundfile = 'sound/urist/guitar/Cb7.ogg'






		else		return

	hearers(15, get_turf(src)) << sound(soundfile)

/obj/item/device/guitar/proc/playsong()
	do
		var/cur_oct[7]
		var/cur_acc[7]
		for(var/i = 1 to 7)
			cur_oct[i] = "3"
			cur_acc[i] = "n"

		for(var/line in song.lines)
			//world << line
			for(var/beat in splittext(lowertext(line), ","))
				//world << "beat: [beat]"
				var/list/notes = splittext(beat, "/")
				for(var/note in splittext(notes[1], "-"))
					//world << "note: [note]"
					if(!playing || !isliving(loc))//If the guitar is playing, or isn't held by a person
						playing = 0
						return
					if(length(note) == 0)
						continue
					//world << "Parse: [copytext(note,1,2)]"
					var/cur_note = text2ascii(note) - 96
					if(cur_note < 1 || cur_note > 7)
						continue
					for(var/i=2 to length(note))
						var/ni = copytext(note,i,i+1)
						if(!text2num(ni))
							if(ni == "#" || ni == "b" || ni == "n")
								cur_acc[cur_note] = ni
							else if(ni == "s")
								cur_acc[cur_note] = "#" // so shift is never required
						else
							cur_oct[cur_note] = ni
					playnote(uppertext(copytext(note,1,2)) + cur_acc[cur_note] + cur_oct[cur_note])
				if(notes.len >= 2 && text2num(notes[2]))
					sleep(song.tempo / text2num(notes[2]))
				else
					sleep(song.tempo)
		if(repeat > 0)
			repeat-- //Infinite loops are baaaad.
	while(repeat > 0)
	playing = 0

/obj/item/device/guitar/attack_self(mob/user as mob)
	if(!isliving(user) || user.stat || user.restrained() || user.lying)	return
	user.set_machine(src)

	var/dat = "<HEAD><TITLE>guitar</TITLE></HEAD><BODY>"

	if(song)
		if(song.lines.len > 0 && !(playing))
			dat += "<A href='?src=\ref[src];play=1'>Play Song</A><BR><BR>"
			dat += "<A href='?src=\ref[src];repeat=1'>Repeat Song: [repeat] times.</A><BR><BR>"
		if(playing)
			dat += "<A href='?src=\ref[src];stop=1'>Stop Playing</A><BR>"
			dat += "Repeats left: [repeat].<BR><BR>"
	if(!edit)
		dat += "<A href='?src=\ref[src];edit=2'>Show Editor</A><BR><BR>"
	else
		dat += "<A href='?src=\ref[src];edit=1'>Hide Editor</A><BR>"
		dat += "<A href='?src=\ref[src];newsong=1'>Start a New Song</A><BR>"
		dat += "<A href='?src=\ref[src];import=1'>Import a Song</A><BR><BR>"
		if(song)
			var/calctempo = (10/song.tempo)*60
			dat += "Tempo : <A href='?src=\ref[src];tempo=10'>-</A><A href='?src=\ref[src];tempo=1'>-</A> [calctempo] BPM <A href='?src=\ref[src];tempo=-1'>+</A><A href='?src=\ref[src];tempo=-10'>+</A><BR><BR>"
			var/linecount = 0
			for(var/line in song.lines)
				linecount += 1
				dat += "Line [linecount]: [line] <A href='?src=\ref[src];deleteline=[linecount]'>Delete Line</A> <A href='?src=\ref[src];modifyline=[linecount]'>Modify Line</A><BR>"
			dat += "<A href='?src=\ref[src];newline=1'>Add Line</A><BR><BR>"
		if(help)
			dat += "<A href='?src=\ref[src];help=1'>Hide Help</A><BR>"
			dat += {"
					Lines are a series of chords, separated by commas (,), each with notes seperated by hyphens (-).<br>
					Every note in a chord will play together, with chord timed by the tempo.<br>
					<br>
					Notes are played by the names of the note, and optionally, the accidental, and/or the octave number.<br>
					By default, every note is natural and in octave 3. Defining otherwise is remembered for each note.<br>
					Example: <i>C,D,E,F,G,A,B</i> will play a C major scale.<br>
					After a note has an accidental placed, it will be remembered: <i>C,C4,C,C3</i> is <i>C3,C4,C4,C3</i><br>
					Chords can be played simply by seperating each note with a hyphon: <i>A-C#,Cn-E,E-G#,Gn-B</i><br>
					A pause may be denoted by an empty chord: <i>C,E,,C,G</i><br>
					To make a chord be a different time, end it with /x, where the chord length will be length<br>
					defined by tempo / x: <i>C,G/2,E/4</i><br>
					Combined, an example is: <i>E-E4/4,/2,G#/8,B/8,E3-E4/4</i>
					<br>
					Lines may be up to 50 characters.<br>
					A song may only contain up to 50 lines.<br>
					"}
		else
			dat += "<A href='?src=\ref[src];help=2'>Show Help</A><BR>"
	dat += "</BODY></HTML>"
	user << browse(dat, "window=guitar;size=700x300")
	onclose(user, "guitar")

/obj/item/device/guitar/Topic(href, href_list)

	if(!in_range(src, usr) || issilicon(usr) || !isliving(usr) || usr.incapacitated())
		usr << browse(null, "window=guitar;size=700x300")
		onclose(usr, "guitar")
		return

	if(href_list["newsong"])
		song = new()
	else if(song)
		if(href_list["repeat"]) //Changing this from a toggle to a number of repeats to avoid infinite loops.
			if(playing) return //So that people cant keep adding to repeat. If the do it intentionally, it could result in the server crashing.
			var/tempnum = input("How many times do you want to repeat this piece? (max:10)") as num|null
			if(tempnum > 10)
				tempnum = 10
			if(tempnum < 0)
				tempnum = 0
			repeat = round(tempnum)

		else if(href_list["tempo"])
			song.tempo += round(text2num(href_list["tempo"]))
			if(song.tempo < 1)
				song.tempo = 1

		else if(href_list["play"])
			if(song)
				playing = 1
				spawn() playsong()

		else if(href_list["newline"])
			var/newline = html_encode(input("Enter your line: ", "guitar") as text|null)
			if(!newline)
				return
			if(song.lines.len > 50)
				return
			if(length(newline) > 50)
				newline = copytext(newline, 1, 50)
			song.lines.Add(newline)

		else if(href_list["deleteline"])
			var/num = round(text2num(href_list["deleteline"]))
			if(num > song.lines.len || num < 1)
				return
			song.lines.Cut(num, num+1)

		else if(href_list["modifyline"])
			var/num = round(text2num(href_list["modifyline"]),1)
			var/content = html_encode(input("Enter your line: ", "guitar", song.lines[num]) as text|null)
			if(!content)
				return
			if(length(content) > 50)
				content = copytext(content, 1, 50)
			if(num > song.lines.len || num < 1)
				return
			song.lines[num] = content

		else if(href_list["stop"])
			playing = 0

		else if(href_list["help"])
			help = text2num(href_list["help"]) - 1

		else if(href_list["edit"])
			edit = text2num(href_list["edit"]) - 1

		else if(href_list["import"])
			var/t = ""
			do
				t = html_encode(input(usr, "Please paste the entire song, formatted:", text("[]", name), t)  as message)
				if(!in_range(src, usr))
					return

				if(length(t) >= 3072)
					var/cont = input(usr, "Your message is too long! Would you like to continue editing it?", "", "yes") in list("yes", "no")
					if(cont == "no")
						break
			while(length(t) > 3072)

			//split into lines
			spawn()
				var/list/lines = splittext(t, "\n")
				var/tempo = 5
				if(copytext(lines[1],1,6) == "BPM: ")
					tempo = 600 / text2num(copytext(lines[1],6))
					lines.Cut(1,2)
				if(lines.len > 50)
					usr << "Too many lines!"
					lines.Cut(51)
				var/linenum = 1
				for(var/l in lines)
					if(length(l) > 50)
						usr << "Line [linenum] too long!"
						lines.Remove(l)
					else
						linenum++
				song = new()
				song.lines = lines
				song.tempo = tempo

	add_fingerprint(usr)
	for(var/mob/M in viewers(1, loc))
		if((M.client && M.machine == src))
			attack_self(M)
	return