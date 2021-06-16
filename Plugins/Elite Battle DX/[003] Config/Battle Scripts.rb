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
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("This time I'll win! Go, #{pname}!")
		end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"Whoa! your #{tname} is really strong!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[0].name
	"Nice hit, my #{pname} can't handle it."
	end,
	"fainted" => "That's what I'm talking about!",
	"recall" => "Swapping out so soon?",
	"lowHPOpp" => "Arrgh not yet!",
	"loss" => "Hah! I knew I could do it.",
	"lowHP" => "We're not done yet.",
	"item" => "Items already huh?",
	"Oppitem" => "Time for a little insurance!"
}
#---------------
  NICK = {
	"beforeLastOpp" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("Let me show you what #{pname} can do!")
		end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"You have trained your #{tname} well!"
	end,
	"turnEnd2" => proc do
	tname = @battlers[0].name
	"Your #{tname} is pretty impressive!"
	end,
	"fainted" => "Wipe out!",
	"recallOpp" => "Time for a switch.",
	"lowHPOpp" => "Hang in there!",
	"loss" => "Try again soon, you almost had it.",
	"lowHP" => "What a nailbiter.",
	"Oppitem" => "Let me think about this."
}
#---------------
  RICHARD = {
	"turnStart0" => proc do
		pname = @battlers[1].name
		@scene.pbTrainerSpeak("You've done well to get this far.")
		end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"You have trained your #{tname} well!"
	end,
	"damageOpp2" => proc do
	pname = @battlers[1].name
	"Quite impresive. #{pname} is taking a beating."
	end,
	"fainted" => "Learning from defeat is a good thing.",
	"recall" => "Hmm, what are you planning?",
	"lowHPOpp" => "My Pokémon will not falter.",
	"loss" => "Thank you for the battle.",
	"lowHP" => "This is close.",
	"item" => "Items won't save you here.",
	"Oppitem" => "I belive some medicine is in order."
}
#---------------
  LORA = {
	"turnStart0" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("You wont easily get my badge #{pname}!")
		end,
	"turnStart5" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("This is quite the battle #{pname}.")
		end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"You and your #{tname} share a strong bond."
	end,
	"damageOpp2" => proc do
	pname = @battlers[1].name
	"#{pname}! Are you okay?"
	end,
	"fainted" => "Faiting is only temporary afterall.",
	"recall" => "A switch? What are you up to.",
	"lowHPOpp" => "Bug Pokémon don't give up easy!",
	"loss" => "Well fought, but you're not ready yet."
}
#---------------
  BRAHM = {
	"turnStart0" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("Let's light it up!")
		end,
	"turnStart5" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("Spicy battle, huh #{pname}?")
		end,
	"damageOpp" => proc do
	tname = @battlers[0].name
	"#{tname} just wont quit!"
	end,
	"damageOpp" => proc do
	pname = @battlers[1].name
	"#{pname} isn't looking too hot."
	end,
	"fainted" => "That Pokémon's done.",
	"recall" => "Switching it up wont save you.",
	"lowHPOpp" => "I'm sweating here!",
	"loss" => "That was intense!",
	"BeforeLastOpp" => "Lets see if I can bring this back."
}
#---------------
  FRITZ = {
	"turnStart0" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("#{pname}, are you ready?")
		end,
	"turnStart5" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("Shocking performance #{pname}.")
		end,
	"damageOpp" => proc do
	pname = @battlers[1].name
	"#{pname}, it's lights out for you!"
	end,
	"fainted" => "That Pokémon's done.",
	"recall" => "Switching it up wont save you.",
	"lowHPOpp" => "I'm sweating here!",
	"loss" => "That was intense!",
	"BeforeLastOpp" => "Power's low, but I'm still going!"
}
#---------------
  HEIDI = {
	"turnStart0" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("#{pname}, prepare for inclement weather!")
		end,
	"turnEnd6" => proc do
		pname = @opponent[1].name
		@scene.pbTrainerSpeak("I'm frozen in awe #{pname}.")
		end,
	"afterLastOpp" => proc do
		pname = @battlers[0].name
		@scene.pbTrainerSpeak("Lets see you handle #{pname}!")
		end,
	"damageOpp" => proc do
	pname = @battlers[1].name
	"#{pname} is getting iced."
	end,
	"recall" => "Switching it up wont save you.",
	"loss" => "Is it cold in here?"
}
#---------------
  LEE = {
	"turnStart0" => proc do
		pname = @opponent[0].name
		@scene.pbTrainerSpeak("#{pname}, your must calm your mind for battle")
		end,
	"turnStart1" => proc do
		pname = @battlers[0].name
		@scene.pbTrainerSpeak("Your #{pname} seems nervous.")
		end,
	"afterLastOpp" => proc do
		pname = @battlers[0].name
		@scene.pbTrainerSpeak("Time for #{pname}, GO!")
		end,
	"recall" => "Hmm, interesting move.",
	"loss" => "Balance in everything."
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
end