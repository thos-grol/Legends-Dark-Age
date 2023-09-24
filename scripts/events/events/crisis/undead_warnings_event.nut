this.undead_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.undead_warnings";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_17.png[/img]While stopping for a brief respite, a stranger approaches the camp. He\'s got a wooden stake for a leg, though he wobbles on it with practiced efficiency. Hobbling to you, he tips a cap of broomstraw.%SPEECH_ON%I suppose you fellas are here for the happenings?%SPEECH_OFF%You glance at %randombrother% then back to the man. He shrugs.%SPEECH_ON%Ah, mayhaps ye don\'t know. I don\'t really know, either, but there be a lot of grisly stories about what is happening all around these parts. The way I hear it, the dead are walking the earth, but that\'s hogwash. I think it\'s just a bunch of brigands with new tricks up their sleeves. Anyway, be seeing you. Stay safe and all that malarkey.%SPEECH_OFF%The man laughs as he stilts away. | [img]gfx/ui/events/event_97.png[/img]A child is found beside the path with a skull laid between their legs. Its upside down with insects battling one another in the bowl of the brainpan. The kid briefly looks up.%SPEECH_ON%Hi there.%SPEECH_OFF%You ask where his parents are. He picks up a dead bug from the skull, looks at it, then tosses it over his shoulder. He puts another wriggling gladiator into the grey arena then stares at you.%SPEECH_ON%Parents? Why they ain\'t been around for awhile. Father went to his parents, and mother to hers. And they both was ate\'n.%SPEECH_OFF%You raise an eyebrow and ask for him to repeat what he just said, but the kid ignores you, absentmindedly cheering into the hollow head as his bugs do battle. | [img]gfx/ui/events/event_18.png[/img]You come to a man standing in the path. He\'s got a shovel yoked over both shoulders, his hands crucifixed across each side, and he\'s dripping with mud. He glances up, this golem of earth, and asks where you\'re going. Before you answer, he interrupts.%SPEECH_ON%Don\'t go that way. Don\'t go no way. They\'re everywhere. I was digging, you see? Digging to get to them first. But they know. They know where we are. Don\'t go nowhere, because they\'re everywhere. Don\'t go nowhere, because they\'re everywhere, and they know... they know, don\'t you see?%SPEECH_OFF%He presses his head forward, his cringing face crooning forth from his dripping arms like some muddied bat come to feast on your dreams. You ease past the man. %randombrother% looks him up and down, shrugs, and follows you. The %companyname% has no time for such madmen. | [img]gfx/ui/events/event_71.png[/img]While on the road, you come to a small, empty hut. %randombrother% snoops around inside, you beside him, the both of you with blades out. He shakes his head.%SPEECH_ON%Ain\'t shit here.%SPEECH_OFF%He looks up and points.%SPEECH_ON%Except there.%SPEECH_OFF%You look up and see that the ceiling is covered in blood. Not just covered... written over. Unfortunately, the script is hard to read as the crimson words are muddied by mold and termitic erasure.\n\n You mouth the visible letters: DO---GO---IDE---WE---LL---R---OOMED.\n\n Clearly the work of a madman. | [img]gfx/ui/events/event_46.png[/img]There\'s a copse in the path, a little set of trees that stand tall in an otherwise flat clearing. You take some respite there, for little trees such as these borrow the silence and sereneness from their larger forest cousins. Except not this one. This one you find a dead child in the bushes.\n\n %randombrother% comes up and covers his mouth.%SPEECH_ON%By the might of the old gods, who would do such a thing?%SPEECH_OFF%You take a knee. There are tracks all over the area. It appears the kid was chased and ended up running into the bushes. Probably got tied up there, stuck. More footsteps followed. Way more. They stayed for a while, then left with bloody footprints. The kid, what is left of him, is covered in bite marks. You turn to the mercenary and answer.%SPEECH_ON%I think it\'s a matter of what, not who. But they\'re gone. Somewhere yonder, a few days ahead I\'d wager, but...%SPEECH_OFF%You count the footsteps, but they prove too many.%SPEECH_ON%I think whatever did this... we\'ll be seeing it soon.%SPEECH_OFF% | [img]gfx/ui/events/event_76.png[/img]You come to a man standing with a white banner, an unthreaded sigil in the middle, its frayed remains billowing in the wind. He nods.%SPEECH_ON%Good to see some flesh.%SPEECH_OFF%Well, that was not what you were expecting as his first words. Naturally, you inquire as to what he means. He looks incredulous.%SPEECH_ON%You know, flesh. As opposed to bones. I\'ve seen too many of those lately so, yeah, it\'s nice seeing some flesh.%SPEECH_OFF%You inquire further, asking what kind of bones this man has been seeing. He slims his eyes as if guarding them against the winds of a past he\'d prefer to forget.%SPEECH_ON%The walkin\' kind. Bones that\'ll walk through your door in the middle of the night. Bones that kill everything in front of them. Bones that want to see more bones just like them. Them sort of bones, got it?%SPEECH_OFF%His face lightens up, the eyes widening. He pivots toward you and suddenly leans forward.%SPEECH_ON%You wouldn\'t happen to be made of bones, would you?%SPEECH_OFF%Sensing a threat in the words, %randombrother% jumps in, positioning to kill the man before he can act. You settle everyone down. The stranger appears at ease, but you order the %companyname% to walk around him with care. He doesn\'t move. He simply stands as the last tendrils of his banner unravel into the wind. | [img]gfx/ui/events/event_40.png[/img]There\'s a man in the path. He\'s on his hands and knees with scrolls littered all around. He bounds from one to the other like a dog would a scattering of treats. He shakes his head.%SPEECH_ON%No no no, no! Where is it? Ah! Stranger! I mean, uh, sellsword, er, friend! Friend?%SPEECH_OFF%You ask what the man is doing. His hands are shaking as he answers.%SPEECH_ON%I, uh, have a theory. About who we are, er, were. In the past. Way before today, understand? Of course you do.%SPEECH_OFF%You watch as the man gathers his notes, stuffing them into a satchel. He continues.%SPEECH_ON%I think our past is coming to haunt us again, my dear sir sellsword friend, and when they come, they will kill us all. Because they want it back. They want it ALL back.%SPEECH_OFF%The man throws the satchel over his shoulder and nods.%SPEECH_ON%Now I have others to inform. Thanks for listening and, uh, farewell.%SPEECH_OFF%Well... bye. | [img]gfx/ui/events/event_75.png[/img]While marching, something crunches awkwardly underfoot. You stop and take a knee to see. Swiping away some dirt, you find splintered shards of pottery. They appear to be, or used to be, part of a piece of art. You piece them together until a picture comes into view. %randombrother% stands behind you and asks.%SPEECH_ON%So, what is that?%SPEECH_OFF%You trace a finger along the artwork. Depicted are armored soldiers with spears and behind them more men stand with polearms, their formation as thick as the forests from which they made their weapons. They appear to be marching forward one step at a time, cutting down all the enemies in their path with brutal efficiency.\n\n You try and pick the shards up. A low hum emits from the clay and each piece suddenly turns to powder, the remains streaming between your fingers. Something that old... that peculiar... what is it doing out here in the middle of nowhere? | [img]gfx/ui/events/event_11.png[/img]An odd figure shuffles across the path. You draw your sword and follow, eventually creeping behind a small girl holding an infant. The child wheels around to look at you, the bundled babe in her arms comfortably asleep. You ask what they are doing way out here. The girl shrugs.%SPEECH_ON%Running from the bads.%SPEECH_OFF%You cautiously glance around before asking what she means. She responds as if the answer to the question is tiresomely obvious.%SPEECH_ON%The bads. We buried them good, but they came up bad. Now they\'re killing everyone. So I run. I run from the bads.%SPEECH_OFF%She peers down at the infant and then out toward the land.%SPEECH_ON%Excuse me, sir. My grandfather lives yonder. He is expecting me and me alone.%SPEECH_OFF%You grab her shoulder and ask where her parents are. She shrugs off your hand.%SPEECH_ON%They\'re with the bads. Now excuse me, I must get going.%SPEECH_OFF%Clutching the baby, the girl quickly ducks into some brush. Such a little thing, she hardly makes a noise thereafter, and you\'ve little doubt that her safe silence will see her to her destination. | [img]gfx/ui/events/event_91.png[/img]You come to an old woman in the road. She waves you down with one hand while the other clutches her neck. As you get closer, you see that her white hairs are waning, leaving a dome of her skull revealed, and her garish nose wheeze with every breath. Age has been most unkind in all resorts. Her words are expectedly labored.%SPEECH_ON%Have you seen an old man on the roads?%SPEECH_OFF%Shaking your head, you ask what happened to her. She reveals her neck from which there are two holes. A bit of pus flows from each until she covers back up.%SPEECH_ON%My husband and I were attacked last night. I don\'t know where he is. I think they took him. They tried to take me, but the man attacking me must\'ve smelled something foul because he got but a small taste before running off. Maybe it was my cooking. I always add too much garlic. My husband, he skipped dinner that night, that grouchy fool.%SPEECH_OFF%You put up a hand, slowing her down. You tell her to carefully explain who or what actually attacked. She nods and responds.%SPEECH_ON%Right, it was...%SPEECH_OFF%She pauses and her eyes seem to change attention, as if she blinked without closing a single eyelid. She glances back at you and smiles.%SPEECH_ON%Hello, have you seen an old man on the roads? He\'s my husband. We were attacked last night and I think they took him...%SPEECH_OFF% | [img]gfx/ui/events/event_16.png[/img]You come to a tiny little town by the side of the path. An insular place where no doubt everyone knows everyone. Outside one of the hovels, there\'s the charred remains of a bonfire. The sickly black shape of a person is in the ruins. One of the townspeople comes over, tipping their strawhat up while tenting their hands on a pitchfork. He speaks rather cheerily.%SPEECH_ON%That right there is taking care of a problem once and for all.%SPEECH_OFF%Curious, you ask what happened. The man answers earnestly, as if happy to relive the moments.%SPEECH_ON%Well, that there deadened thing you see used to be %randomname%. The man lived yonder from here, in the backend parts of this backend town. He used to do readings, like you know, from bones and blood or some sorry sortition. Fool kept going on and on about how the dead were going to come back and kill us all. We don\'t take kindly to shamanistic reckonings so we gave him the straight-and-narrow side of what is right and lawful.%SPEECH_OFF%The man spits and nods.%SPEECH_ON%And that was that.%SPEECH_OFF%Almost as if on cue, the bonfire crumbles and the boneshards scatter. A plume of ash and smoke are all that remain. | [img]gfx/ui/events/event_57.png[/img]You come across a graveyard off to the side of the path. The place is a mess. The plots are uncovered and the gravestones overturned and scattered. It is as if a horde of graverobbers descended upon the place and picked it clean. Except... they took the bodies too? %randombrother% stands at your side and shakes his head.%SPEECH_ON%Cannibals?%SPEECH_OFF%This was not the work of cannibals, but you nod for that answer is more calming then what might be the truth: whatever was buried here got up and left on their own two feet... | [img]gfx/ui/events/event_46.png[/img]While marching, you come across an abandoned camp. %randombrother% walks through it and kick over a pan slick with oil. Rotten bacon and eggs spill into the grass. He turns his attention to some bags but comes up empty.\n\n The ground reveals fresh footprints. A clutter of them circle around what was the fire, but there is no dance in their evidence, instead it seems they were frantically rushing to and fro. Marching toward them is a horde of prints, shuffling and dragging their feet with no order. And then, as these two storied prints meet, only the latter continues forward.\n\n %randombrother% pulls back a bush to reveal a dead body. There\'s a shovel firmly slotted into its skull. The skin of it makes you think the person had been dead for at least two or three weeks - so the footprints are far too fresh for this body to have created them. You\'ve no idea what happened here, but it could not have been good. Going forward, the men of %companyname% should stay sharp for some evil walks these lands.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s concerning...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.FactionManager.getGreaterEvilType() == ::Const.World.GreaterEvilType.Undead && this.World.FactionManager.getGreaterEvilPhase() == ::Const.World.GreaterEvilPhase.Warning)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();

			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(playerTile) <= 4)
				{
					return;
				}
			}

			this.m.Score = 80;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

