###########################################
# BERRY CENTRIFUGE
# Credits: AiurJordan,GolisopodUser,Vendily
# Inspiration: Crafting System by ThatWelshOne_
###########################################
# HOW TO USE
# Simply call the script "pbBerryCentrifuge"
#
# This breaks berries down into other items based on
# a random chance, the items are called 
# :BERRYA, :BERRYT, :BERRYC, :BERRYG, :BERRYU
# This is based on DNA/RNA where in the real world 
# Thiamine and Uracil are never present together.
#
# You will need to add the following five items to your items.txt
#
# Change XXX to your desired item ID, it must be unique.
# XXX,BERRYA,Berry Adenine,Berry Adenine,5,10,"Berry Adenine nucleotide used for crafting any berry!",0,0,0,
# XXX,BERRYT,Berry Thymine,Berry Thymine,5,50,"Berry Thymine nucleotide used for crafting any berry!",0,0,0,
# XXX,BERRYG,Berry Guanine,Berry Guanine,5,100,"Berry Guanine nucleotide used for crafting any berry!",0,0,0,
# XXX,BERRYC,Berry Cytosine,Berry Cytosine,5,500,"Berry Cytosine nucleotide used for crafting any berry!",0,0,0,
# XXX,BERRYU,Berry Uracil,Berry Uracil,5,1000,"Berry Uracil nucleotide used for crafting any berry!",0,0,0,
#
# Then install the associated graphics with the plugin
# place the items in the Graphics/Items folder in your
# project directory.
#
# These items do not do anything by themselves, but
# you are encouraged to find a use for these items
# via selling or combining, or alternatively I recommend
# that you use ThatWelshOne_'s item crafting system to
# allow these to be combined in a crafting interface.
#
# Currently the items and chances are hard coded, as well as the pocket message at the bottom.
# You could change this script to do anything you wanted, it does not have to be berries!
##########################################
def pbBerryCentrifuge

ret = nil

#select berry from bag
pbFadeOutIn {
  scene = PokemonBag_Scene.new
  screen = PokemonBagScreen.new(scene,$PokemonBag)
  
  #is_berry? checks to make sure it's a berry, if you're changing the script you'll need to change that line
  ret = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_berry? })
}

#select number of berries in bag and delete them
	if ret
	  params = ChooseNumberParams.new
	  params.setRange(1, $PokemonBag.pbQuantity(ret))
	  params.setInitialValue(1)
	  params.setCancelValue(0)
	  components = []
	  qty = pbMessageChooseNumber(_INTL("Select the number of {1} to break down. (ESC to quit).", GameData::Item.get(ret).name_plural), params)
	  #deletes the items from the bag that the player selected
	  $PokemonBag.pbDeleteItem(ret, qty) if qty > 0
	  
	  #break berries down into ATGC/U qty times in each case statement
	case ret
		when nil
			pbMessage("Did not select a berry.")
		# 2 hour berries
		when :RAZZBERRY,:BLUKBERRY,:NANABBERRY,:WEPEARBERRY,:PINAPBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..75
						components.push(:BERRYA)
					when 76..80
						components.push(:BERRYT)
					when 81..99
						components.push(:BERRYG)
					when 99..100
						components.push(:BERRYC)
				end
			end
		# 3 hour berries
		when :CHERIBERRY,:CHESTOBERRY,:PECHABERRY,:RAWSTBERRY,:ASPEARBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..50
						components.push(:BERRYA)
					when 51..75
						components.push(:BERRYT)
					when 76..90
						components.push(:BERRYG)
					when 91..100
						components.push(:BERRYC)
				end
			end
		# 4 hour berries	
		when :ORANBERRY,:LEPPABERRY,:PERSIMBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..40
						components.push(:BERRYA)
					when 41..69
						components.push(:BERRYT)
					when 70..88
						components.push(:BERRYG)
					when 89..100
						components.push(:BERRYC)
				end
			end
		# 5 hour berries
		when :FIGYBERRY,:WIKIBERRY,:MAGOBERRY,:AGUAVBERRY,:IAPAPABERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..35
						components.push(:BERRYA)
					when 36..60
						components.push(:BERRYU)
					when 61..80
						components.push(:BERRYG)
					when 81..100
						components.push(:BERRYC)
				end
			end
		# 6 hour berries
		when :CORNNBERRY,:MAGOSTBERRY,:RABUTABERRY,:NOMELBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..30
						components.push(:BERRYA)
					when 31..50
						components.push(:BERRYU)
					when 51..69
						components.push(:BERRYG)
					when 70..100
						components.push(:BERRYC)
				end
			end
		# 8 hour berries
		when :POMEGBERRY,:KELPSYBERRY,:QUALOTBERRY,:HONDEWBERRY,:GREPABERRY,:TAMATOBERRY,:SITRUSBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..20
						components.push(:BERRYA)
					when 21..40
						components.push(:BERRYT)
					when 41..60
						components.push(:BERRYG)
					when 61..100
						components.push(:BERRYC)
				end
			end
		# 12 hour berries
		when :LUMBERRY,
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..10
						components.push(:BERRYA)
					when 11..20
						components.push(:BERRYU)
					when 21..40
						components.push(:BERRYG)
					when 41..100
						components.push(:BERRYC)
				end
			end
		# 15 hour berries
		when :SPELONBERRY,:PAMTREBERRY,:WATMELBERRY,:DURINBERRY,:BELUEBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..25
						components.push(:BERRYA)
					when 26..50
						components.push(:BERRYT)
					when 51..75
						components.push(:BERRYG)
					when 76..100
						components.push(:BERRYC)
				end
			end
		#18 hour berries
		when :OCCABERRY,:PASSHOBERRY,:WACANBERRY,:RINDOBERRY,:YACHEBERRY,:CHOPLEBERRY,:KEBIABERRY,:SHUCABERRY,
		:COBABERRY,:PAYAPABERRY,:TANGABERRY,:CHARTIBERRY,:KASIBBERRY,:HABANBERRY,:COLBURBERRY,:BABIRIBERRY,:CHILANBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..5
						components.push(:BERRYA)
					when 6..11
						components.push(:BERRYC)
					when 12..40
						components.push(:BERRYG)
					when 41..100
						components.push(:BERRYU)
				end
			end
		#18 hr separating gen 6 for compatibility
		when :ROSELIBERRY, :KEEBERRY, :MARANGABERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..11
						components.push(:BERRYA)
					when 12..35
						components.push(:BERRYG)
					when 36..75
						components.push(:BERRYC)
					when 76..100
						components.push(:BERRYU)
				end
			end
		#24 hour berries
		when :LIECHIBERRY,:GANLONBERRY,:SALACBERRY,:PETAYABERRY,:APICOTBERRY,:LANSATBERRY,:STARFBERRY,:ENIGMABERRY,
		:MICLEBERRY,:CUSTAPBERRY,:JABOCABERRY,:ROWAPBERRY
			for i in 1..qty
				v = rand(1..100)
				case v
					when 1..11
						components.push(:BERRYA)
					when 12..25
						components.push(:BERRYG)
					when 26..67
						components.push(:BERRYC)
					when 68..100
						components.push(:BERRYU)
				end
			end
		end

		#push components into player bag
		components.each do |item|
			next if !$PokemonBag.pbCanStore?(item,  1)
				pbSEPlay("Battle ball hit")
				#found item message, note that the pocket is hard coded
				pbMessage(_INTL("Spun down some \\c[1]{1}\\c[0], \\PN put it in the <icon=bagPocket5>\\c[1]Berry Pocket\\c[0]!",GameData::Item.get(item).name))
				$PokemonBag.pbStoreItem(item, 1)
			end
		
	end
end
#If you're reading this you're awesome, I hope you find a cool application for this script.