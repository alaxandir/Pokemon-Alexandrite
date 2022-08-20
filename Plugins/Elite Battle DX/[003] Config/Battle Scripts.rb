#===============================================================================
#  Elite Battle: DX
#    by Luka S.J.
# ----------------
#  Battle Scripts
#===============================================================================
module BattleScripts
  # example scripted battle for PIDGEY
  # you can define other scripted battles in here or make your own section
  # with the BattleScripts module for better organization as to not clutter the
  # main EBDX cofiguration script (or keep it here if you want to, your call)
  PIDGEY = {
    "turnStart0" => {
      :text => [
        "Wow! This here Pidgey is among the top percentage of Pidgey.",
        "I have never seen such a strong Pidgey!",
        "Btw, this feature works even during wild battles.",
        "Pretty exciting, right?"
      ],
      :file => "trainer024"
    }
  }
  # to call this battle script run the script from an event jusst before the
  # desired battle:
  #    EliteBattle.set(:nextBattleScript, :PIDGEY)
  #-----------------------------------------------------------------------------
  # example scripted battle for BROCK
  # this one is added to the EBDX trainers PBS as a BattleScript parameter
  # for the specific battle of LEADER_Brock "Brock" trainer
  BROCK = {
    "turnStart0" => proc do
      pname = @battlers[1].name
      tname = @battle.opponent[0].name
      # begin code block for the first turn
      @scene.pbTrainerSpeak(["Time to set this battle into motion!",
                             "Let's see if you'll be able to handle my #{pname} after I give him this this!"
                           ])
      # play common animation for Item use args(anim_name, scene, index)
      @scene.pbDisplay("#{tname} tossed an item to the #{pname} ...")
      EliteBattle.playCommonAnimation(:USEITEM, @scene, 1)
      # play aura flare
      @scene.pbDisplay("Immense energy is swelling up in the #{pname}")
      EliteBattle.playCommonAnimation(:AURAFLARE, @scene, 1)
      @vector.reset # AURAFLARE doesn't reset the vector by default
      @scene.wait(16, true) # set true to anchor the sprites to vector
      # raise battler Attack sharply (doesn't display text)
      @battlers[1].pbRaiseStatStageBasic(:ATTACK, 2)
      # show trainer speaking additional text
      @scene.pbTrainerSpeak("My #{pname} will not falter!")
      # show generic text
      @scene.pbDisplay("The battle is getting intense! You see the lights and stage around you shift.")
      # change Battle Environment (with white fade)
      pbBGMPlay("Battle Elite")
      @sprites["battlebg"].reconfigure(:STAGE, Color.white)
    end,
    "damageOpp" => "Woah! A powerful move!",
    "damageOpp2" => "Another powerful move ...",
    "lastOpp" => "This is it! Let's make it count!",
    "lowHPOpp" => "Hang in there!",
    "attack" => "Whatever you throw at me, my team can take it!",
    "attackOpp" => "How about you try this one on for size!",
    "fainted" => "That's how we do it in this gym!",
    "faintedOpp" => "Arghh. You did well my friend...",
    "loss" => "You can come back and challenge me any time you want."
	}
#--------------
  BRETT1 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("We'll be good rivals #{tname}, goodluck!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Whoa! your #{tname} is really strong!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Nice hit, my #{pname} can't handle it."
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, don't give up!")
	end,
	"fainted" => "That's what I'm talking about!",
	"recall" => "Swapping out so soon?",
	"lowHPOpp" => "Arrgh not yet!",
	"loss" => "Hah! I knew I could do it.",
	"lowHP" => "We're not done yet.",
	"item" => "Items already huh?",
	"Oppitem" => "Time for a little insurance!"
}
#---------------# BATTLER 0 IS PLAYER, BATTLER 1 IS OPPONENT
  NICK = {
	"beforeLastOpp" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("Let me show you what Piplup can do!")
		end,
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("Alright #{tname}, let's battle!")
	end,
	"lowHP" => proc do
	tname = @battlers[0].name
	@scene.pbTrainerSpeak("That #{tname} is tough!")
	end,
	"lowHP2" => proc do
	tname = @battlers[0].name
	@scene.pbTrainerSpeak("No way #{tname} is still standing!")
	end,
	"turnEnd3" => proc do
	tname = @battlers[0].name
	@scene.pbTrainerSpeak("Your #{tname} is really impressive!")
	end,
	"fainted" => "Wipe out!",
	"recallOpp" => "Time for a switch.",
	"lowHPOpp" => "Hang in there!",
	"loss" => "Try again soon, you almost had it.",
	"lowHP" => "What a nail-biter.",
	"Oppitem" => "Let me think about this."
}
#----------------# BATTLER 0 IS PLAYER, BATTLER 1 IS OPPONENT
  RICHARD = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("You've done well to come this far #{tname}.")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	@scene.pbTrainerSpeak("You have trained your #{tname} well!")
	end,
	"damageOpp2" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("Quite impresive. #{pname} is taking a beating.")
	end,
	"fainted" => "Learning from defeat is a good thing.",
	"recall" => "Hmm, what are you planning?",
	"lowHPOpp" => "My Pokémon will not falter.",
	"loss" => "Thank you for the battle.",
	"lowHP" => "This is close.",
	"item" => "Items won't save you here.",
	"Oppitem" => "I believe some medicine is in order."
}
#---------------
  LORA = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("You wont get my badge easily #{tname}!")
	end,
	"turnStart5" => "This is quite the battle.",
	"turnStart6" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("You and your #{pname} share a strong bond.")
	end,
	"lowHPOpp" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}! Are you okay?")
	end,
	"fainted" => "Fainting is only temporary afterall.",
	"lowHPOpp" => "Bug Pokémon don't give up easy!",
	"loss" => "Well fought, but you're not ready yet."
}
#----------------# BATTLER 0 IS PLAYER, BATTLER 1 IS OPPONENT
  BRAHM = {
	"turnStart0" => "Let's light it up!",
	"turnStart5" => "Spicy battle, huh?",
	"damageOpp" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("Your #{pname} just wont quit!")
	end,
	"damageOpp1" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname} isn't looking too hot.")
	end,
	"fainted" => "That Pokémon's done.",
	"lowHPOpp" => "I'm sweating here!",
	"loss" => "That was intense!",
	"BeforeLastOpp" => "Lets see if I can bring this back."
}
#----------------# BATTLER 0 IS PLAYER, BATTLER 1 IS OPPONENT
  FRITZ = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, I will be your greatest challenge yet!")
	end,
	"turnStart5" => "A shocking performance so far!",
	"damage" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("#{pname}, it's lights out for you!")
	end,
	"fainted" => "That Pokémon's done.",
	"lowHPOpp" => "I'm just hanging in there!",
	"loss" => "Fearless combat!",
	"BeforeLastOpp" => "Power's low, but I'm still going!"
}
#---------------
HEIDI = {
	"turnStart0" => "I hope you brought your winter coat!",
	"turnEnd6" => "I'm frozen in awe.",
	"afterLastOpp" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("Lets see if you can handle #{pname}!")
		end,
	"mega" => "Finally, I was waiting for this!",
	"megaopp" => "Here.. we.. GO!",
	"damage" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("#{pname} is getting iced.")
	end,
	"loss" => "Is it cold in here?"
}
#---------------# BATTLER 0 IS PLAYER, BATTLER 1 IS OPPONENT
LEE = {
	"turnStart0" => "You must calm your mind for battle",
	"turnStart1" => proc do
		pname = @battlers[0].name
		@scene.pbTrainerSpeak("Your #{pname} seems nervous.")
		end,
	"afterLastOpp" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("Time for #{pname}, GO!")
		end,
	"recall" => "Hmm, interesting move.",
	"loss" => "Balance in everything."
}

HAOAI = {
	"turnStart0" => "We hope you are ready for the battle of a lifetime!",
	"turnStart1" => proc do
		pname = @battlers[0].name
		@scene.pbTrainerSpeak("Have you trained #{pname} well enough?")
		end,
	"afterLastOpp" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("The finale awaits, #{pname}, GO!")
		end,
	"megaOpp" => "Time to take this to the limit!",
	"fainted" => "You're not ready for this challenge..",
	"fainted2" => "One by one they fall.",
	"lowHPOpp" => "Such intensity, you are fascinating!",
}
#---------------
  GIOVANNI1 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! You've meddled in my affairs long enough.")
	end,
	"turnStart5" => "This should not be too difficult.",
	"turnStart6" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("Your #{pname}, I will cherish it...")
	end,
	"lowHPOpp" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}! Get back in there!")
	end,
	"megaOpp" => "BEHOLD! The power of the Mega Ring!",
	"fainted" => "You have no chance against me.",
	"fainted2" => "You're faltering.",
	"lowHPOpp" => "These Pokémon are too weak!",
	"afterLastOpp" => "This is impossible!",
	"afterLast" => "Foolish child, your defeat is imminent.",
	"loss" => "Futile, you will remember this day."
}
#----------------
  GIOVANNI2 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! Hand over that tablet.")
	end,
	"turnStart4" => "This is getting irritating.",
	"turnStart6" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("Your #{pname}, how is it so strong?")
	end,
	"turnStart10" => "Such power, you would do well to join me.",
	"turnStart15" => "This is... interesting. Do you have a plan now?",
	"lowHPOpp" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}! Get back in there!")
	end,
	"megaOpp" => "It's time to stop toying with you.",
	"fainted" => "Give up, you can't win.",
	"fainted2" => "Don't worry, it'll all be over soon.",
	"fainted2" => "<laughs> You're beaten.",
	"recall" => "Stop delaying the inevitable.",
	"recall2" => "Stop wasting my time.",
	"recall3" => "You're really persistent aren't you...",
	"recall4" => "Enough of this, stop trying to defeat me.",
	"lowHPOpp2" => "Argh, come on you, keep fighting!",
	"lowHPOpp3" => "If you give up, you will be punished!",
	"afterLastOpp" => "W-What?",
	"afterLast" => "Foolish child, you're defeat is imminent.",
	"loss" => "I'll be taking that tablet now."
}
  #-----------------------------------------------------------------------------
  # example Dialga fight
  DIALGA = {
    "turnStart0" => proc do
      # hide databoxes
      @scene.pbHideAllDataboxes
      # show flavor text
      @scene.pbDisplay("The ruler of time itself; Dialga starts to radiate tremendous amounts of energy!")
      @scene.pbDisplay("Something is about to happen ...")
      # play common animation
      EliteBattle.playCommonAnimation(:ROAR, @scene, 1)
      @scene.pbDisplay("Dialga's roar is pressurizing the air around you! You feel its intensity!")
      # change the battle environment (use animation to transition)
      @sprites["battlebg"].reconfigure(:DIMENSION, :DISTORTION)
      @scene.pbDisplay("Its roar distorted the dimensions!")
      @scene.pbDisplay("Dialga is controlling the domain.")
      # show databoxes
      @scene.pbShowAllDataboxes
    end
  }
  #-----------------------------------------------------------------------------
  BRETT2 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("Alright, time for a rematch #{tname}!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Whoa! your #{tname} is really strong!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Nice hit, my #{pname} can't handle it."
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, don't give up!")
	end,
	"fainted" => "That's what I'm talking about!",
	"recall" => "Swapping out so soon?",
	"lowHPOpp" => "Arrgh not yet!",
	"loss" => "Hah! I knew I could do it.",
	"lowHP" => "We're not done yet.",
	"item" => "Items already huh?",
	"Oppitem" => "Time for a little insurance!"
}
  #-----------------------------------------------------------------------------
  BRETT3 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! I'm coming for you!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Whoa! your #{tname} is really strong!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Nice hit, my #{pname} can't handle it."
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, don't give up!")
	end,
	"fainted" => "That's what I'm talking about!",
	"recall" => "Swapping out so soon?",
	"lowHPOpp" => "Arrgh not yet!",
	"loss" => "Hah! I knew I could do it.",
	"lowHP" => "We're not done yet.",
	"item" => "Items already huh?",
	"Oppitem" => "Time for a little insurance!"
}
  #-----------------------------------------------------------------------------
  BRETT5 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("You're done #{tname}. I'm through messing around. ")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Unreal, #{tname} is really strong!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"#{pname}... Don't go down!"
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, please don't give up!")
	end,
	"fainted" => "Yes, YES!",
	"recall" => "Hmph, swapping.",
	"lowHPOpp" => "No, I can't lose!",
	"loss" => "Oh, that... you went easy didn't you...",
	"lowHP" => "We're not done yet!",
	"item" => "... Really?",
	"Oppitem" => "I didn't want to have to use this..."
}
#-----------------------------------------------------------------------------
  BRETT6 = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, you better try your hardest. I'm not joking around.")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"#{tname}, I hate that thing."
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"#{pname}, you've failed me for the last time!"
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, you need to win this for me.")
	end,
	"fainted" => "Maybe there's hope.",
	"fainted2" => "What? Another one? Yes!",
	"recall" => "Urgh! Stop wasting time.",
	"recall2" => "Swapping is so annoying.",
	"lowHPOpp" => "... Don't you dare faint on me!",
	"lowHPOpp2" => "Why? WHY DO I ALWAYS LOSE!?",
	"damageOpp3" => "Haha! YES!",
	"damageOpp4" => "You're going down!",
	"lowHPOpp3" => "If you go down we've got no chance.",
	"loss" => "So this is it...",
	"lowHP" => "Yes, this is happening!",
	"lowHP2" => "Oh my gosh, it's really happening!",
	"lowHP3" => "Hit it harder! Go now! Attack!"
}
  BRETT7 = {

}
#-----------------------------------------------------------------------------
ROBERT = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("Alright #{tname}, show me what you're made of!")
	end,
	"damageOpp" => proc do
	pname = @battlers[0].name
	"Excellent technique by your #{pname}!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Nice hit, my #{pname} is faltering."
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, don't give up!")
	end,
	"fainted" => "What a fighter!",
	"lowHPOpp" => "I fear this is not going well!",
	"lowHPOpp2" => "My Pokémon just cant cut it.",
	"loss" => "You fought well, come back soon.",
	"lowHP" => "We're not done yet!",
	"item" => "Items are frowned upon in the League Challenge."
}

WILLIAM = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! Your league challenge ends here!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"What a strong #{tname}! What's your secret?"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"#{pname}, hang in there buddy!"
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, you've been through worse come on!")
	end,
	"fainted" => "That was too easy.",
	"lowHPOpp" => "You're winning, but I'm not done yet!",
	"lowHPOpp2" => "No no no! Still standing... Phew!",
	"loss" => "You fought well, I'll take you on anytime.",
	"lowHP" => "Your Pokémon, how is it still standing?",
	"lowHP2" => "Still alive? You gotta be kidding me."
}

WILLIAM = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! Your league challenge ends here!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"What a strong #{tname}! What's your secret?"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"#{pname}, hang in there buddy!"
	end,
	"turnStart4" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, you've been through worse come on!")
	end,
	"fainted" => "That was too easy.",
	"lowHPOpp" => "You're winning, but I'm not done yet!",
	"lowHPOpp2" => "No no no! Still standing... Phew!",
	"loss" => "You fought well, I'll take you on anytime.",
	"lowHP" => "Your Pokémon, how is it still standing?",
	"lowHP2" => "Still alive? You gotta be kidding me."
}

KYRA = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}! #{tname}!! #{tname}!!!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"I like that #{tname}! They are really giving it their all."
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"#{pname}, they said you can't give up yet! They said no!"
	end,
	"turnStart7" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, they're telling me you're doing good!")
	end,
	"fainted" => "They like it when that happens.",
	"fainted2" => "That one was really satisfying.",
	"fainted3" => "Ooh! Another one, yes! yes!!",
	"lowHPOpp" => "Oh no, it might be hurt. Should we stop?",
	"lowHPOpp2" => "I'm not sure that went as planned.",
	"loss" => "They enjoyed this fight, they wish to see you again.",
	"lowHP" => "Only a very well trained battler would withstand that. You're a good match.",
	"lowHP2" => "They didn't like that, you should be fainted by now."
}

ANYA = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, you really think you can do this?")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Hmm, impressive... your #{tname} at least, not sure about you yet."
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"That #{pname} is really something isn't it?"
	end,
	"turnStart5" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, don't you let this kid beat you!")
	end,
	"fainted" => "Too easy.",
	"fainted2" => "You're out of your league kid.",
	"fainted3" => "Just give up already.",
	"lowHPOpp" => "Hmph, you think that's enough to stop me?",
	"lowHPOpp2" =>  "You're gonna have to do better than that.",
	"loss" => "I think you've got some potential, maybe come back when you're older.",
	"lowHP" => "I didn't expect that, what a surprise.",
	"lowHP2" => "You can't be serious, you're still standing?"
}

JAY = {
	"turnStart0" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, as the Cardino League Champion. I accept your challenge!")
	end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"You might just have what it takes if you trained that #{tname}."
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Impressive show by your #{pname}."
	end,
	"turnStart5" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("#{pname}, I know this is tough but you can do it.")
	end,
	"turnStart12" => proc do
		tname = $Trainer.name
		@scene.pbTrainerSpeak("#{tname}, is your confidence failing you?")
	end,
	"turnStart24" => proc do
		tname = $Trainer.name
		@scene.pbTrainerSpeak("This fight is really something isn't it #{tname}?")
	end,
	"turnStart33" => proc do
		tname = $Trainer.name
		@scene.pbTrainerSpeak("Stalling isn't going to help you #{tname}. Stop this nonsense!")
	end,
	"fainted" => "That's one down.",
	"fainted2" => "Two down, too easy.",
	"fainted3" => "Three down already?",
	"fainted4" => "Four... You're getting nervous now I'll bet.",
	"fainted5" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, come on! Do you give up so easily?")
	end,
	"lowHPOpp" => "Shrug it off, not enough to stop us!",
	"lowHPOpp2" =>  "Unexpected turn of events, you're quite a match for me.",
	"loss" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, please do challenge me again soon. I look forward to it.")
	end,
	"lowHP" => "Oh, you endured that? Impressive!",
	"lowHP2" => proc do
	pname = @battlers[0].name
	"How is #{pname} still standing?!"
	end
}

#----------------
  GIOVANNI3 = {
    "turnStart0" => proc do
      # hide databoxes
      @scene.pbHideAllDataboxes
      # show flavor text
      @scene.pbDisplay("Mewtwo's psychic energy warps the battlefield!")
      # play common animation
      EliteBattle.playCommonAnimation(:AURAFLARE, @scene, 1)
      # change the battle environment (use animation to transition)
      @sprites["battlebg"].reconfigure(:DIMENSION, :DISTORTION)
      @scene.pbDisplay("Its mind distorted the battlefield!")
      # show databoxes
      @scene.pbShowAllDataboxes
    end, 
	"turnStart2" => proc do
	tname = $Trainer.name
	@scene.pbTrainerSpeak("#{tname}, you've crossed me for the last time.")
	end,
	"turnStart4" => "You little brat, I'm getting angry.",
	"turnStart6" => proc do
	pname = @battlers[0].name
	@scene.pbTrainerSpeak("Your #{pname}, how is it so strong?")
	end,
	"turnStart10" => "I can taste your fear, it's tempting to kill you quickly.",
	"turnStart15" => "Why won't you die!?",
	"lowHPOpp" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}! Don't you dare quit.")
	end,
	"megaOpp" => "It's time to stop toying with you.",
	"fainted" => "Give up, you can't win.",
	"fainted2" => "Don't worry, it'll all be over soon.",
	"fainted2" => "<laughs> You're beaten.",
	"lowHPOpp2" => "Argh, come on, keep fighting!",
	"lowHPOpp3" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}, if you give up, you will be punished!")
	end,
	"afterLastOpp" => proc do
	pname = @battlers[1].name
	@scene.pbTrainerSpeak("#{pname}! Don't dissapoint me old friend.")
	EliteBattle.playCommonAnimation(:AURAFLARE, @scene, 1)
	@battlers[1].pbRaiseStatStageBasic(:ATTACK, 2)
	@battlers[1].pbRaiseStatStageBasic(:DEFENSE, 2)
	@battlers[1].pbRaiseStatStageBasic(:SPECIAL_DEFENSE, 2)
	@battlers[1].pbRaiseStatStageBasic(:SPEED, 2)
	@scene.pbDisplay("Persian looks ready to fight to the last breath!")
	@scene.pbDisplay("Persian's stats increased dramatically!")
	end,
	"afterLast" => "Foolish child, no more games!",
	"loss" => "Fufufu, you're mine!"
}
end