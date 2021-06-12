Prizes = [
[:POKEBALL,:GREATBALL,:POKEBALL,:ULTRABALL,:POKEBALL,:GREATBALL,:POKEBALL,:GREATBALL,:POKEBALL,:ULTRABALL],
[:CHARMANDER,:TOGEPI,:EEVEE,:ZUBAT,:CLEFFA,:RATTATA,:SQUIRTLE,:ZUBAT,:BULBASAUR,:RATTATA],
["100","2500","100","7500","100","10000","100","5000","100","15000"],
[:ZINC,:CARBOS,:WISEGLASSES,:CALCIUM,:MUSCLEBAND,:IRON,:RARECANDY,:PROTEIN,:LIFEORB,:HPUP],

]


WheelStyles = [
#bg graphic, wheel graphic, radius, minimum spins,
#spin SFX, volume, pitch
#winning sfx, volume, pitch
["hatchbg","prizewheel",144,3,"Artist",100,100,"mining reveal full",100,100],
["hatchbg","prizewheel2",144,3,"Artist",100,100,"mining reveal full",100,100]
]

def Wheel(prizelist,cost,style=0)
  PrizeWheel.new(prizelist,cost,style)
end


class PrizeWheel


  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end


  def initialize(prizelist,cost,style=0)
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @prizes=Prizes[prizelist]
    @sprites = {}
    @cost=cost
    @style=WheelStyles[style]
    @bg=@style[0]
    @wheel=@style[1]
    @minspins=@style[3]
    @prizespin=0
    @angle=[72,36,0,313,287,251,216,180,144,108]
    @xyangle=[198,234,270,306,340,16,52,90,126,162]
    @sprites["bg"] = Sprite.new(@viewport)
    @sprites["bg"].bitmap = Bitmap.new("Graphics/Pictures/#{@bg}")
    @sprites["downarrow"] = AnimatedSprite.new("Graphics/Pictures/downarrow",8,28,40,2,@viewport)
    @sprites["downarrow"].x = (Graphics.width/2)-16
    @sprites["downarrow"].y = 0
    @sprites["downarrow"].z = 5
    @sprites["downarrow"].play
    @sprites["wheel"] = Sprite.new(@viewport)
    @sprites["wheel"].bitmap = Bitmap.new("Graphics/Pictures/#{@wheel}")
    @sprites["wheel"].center_origins
    @sprites["wheel"].x=Graphics.width/2
    @sprites["wheel"].y=Graphics.height/2
    for i in 0...10
      if GameData::Item.try_get(@prizes[i])
        @sprites["prize#{i}"]=ItemIconSprite.new(0,0,0,@viewport)
        @sprites["prize#{i}"].item = @prizes[i]
        @sprites["prize#{i}"].ox=24
        @sprites["prize#{i}"].oy=24
      elsif GameData::Species.try_get(@prizes[i])
        @sprites["prize#{i}"]=PokemonSpeciesIconSprite.new(@prizes[i],@viewport)
         @sprites["prize#{i}"].ox=32
        @sprites["prize#{i}"].oy=32
      else
        @sprites["prize#{i}"] = Sprite.new(@viewport)
        @sprites["prize#{i}"].bitmap = Bitmap.new("Graphics/Pictures/Money")
        @sprites["prize#{i}"].center_origins
      end
      @sprites["prize#{i}"].angle = @angle[i]
      @sprites["prize#{i}"].x=(Graphics.width/2) + Math.cos(@xyangle[i].degrees)*@style[2]
      @sprites["prize#{i}"].y=(Graphics.height/2) + Math.sin(@xyangle[i].degrees)*@style[2]
    end
    main
  end

  def main
    loop do
      pbBGMPlay("anthophilgamecorner.ogg")
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::C)
        if @cost>0
          confirmtext="\\CNSpin the wheel for #{@cost} coins? (ESC to quit)"
        else
          confirmtext="\\CNSpin the wheel?"
        end
          if pbConfirmMessage("#{confirmtext}")
            if $Trainer.coins>=@cost
              $Trainer.coins-=@cost
            else
              pbMessage(_INTL("\\CNYou don't have enough coins..."))
              break
            end
		  pbMEPlay(@style[4],@style[5],@style[6])
          spins=rand(360)
          spins+=360*(@minspins)
          spun=0
          click=true
          loop do
          pbUpdate
            @sprites["wheel"].angle -= 5
            @prizespin+=5
             for i in 0...10
              @sprites["prize#{i}"].angle -= 5
                @sprites["prize#{i}"].x= (Graphics.width/2) + Math.cos((@xyangle[i]+@prizespin).degrees)*@style[2]
                @sprites["prize#{i}"].y= (Graphics.height/2) + Math.sin((@xyangle[i]+@prizespin).degrees)*@style[2]
            end
            spun+=5
            Graphics.update
            if click=true
               click=false
              else
                click=true
            end
            if spun>=spins
            prize=0
            prizey=[]
            for i in 0...10
              prizey[i]=@sprites["prize#{i}"].y
            end
             winner=prizey.min
              for i in 0...10
                if @sprites["prize#{i}"].y==winner
                   prize=i
                 end
              end
              prize=@prizes[prize]
              pbSEPlay(@style[7],@style[8],@style[9])
              if GameData::Item.try_get(prize)
                pbUpdate
                pbReceiveItem(prize)
              elsif GameData::Species.try_get(prize)
                pbUpdate
                  pbAddPokemon(prize,20)
              else
                pbMessage("You won $#{prize}!")
                prize = prize.to_i
                $Trainer.money+=prize
              end
            break
            end
          end
        end
      end
      if Input.trigger?(Input::B)
        break
      end
    end
    pbFadeOutAndHide(@sprites) {pbUpdate}
    dispose
  end

  def dispose
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end


#center_origins command from Marin's Scripting Utilities.
#If you have that script, you can delete this section
class Sprite
    def center_origins
      return if !self.bitmap
      self.ox = self.bitmap.width / 2
      self.oy = self.bitmap.height / 2
  end
end



#.degrees command, to convert degrees to radians
class Numeric
     def degrees
     self * Math::PI / 180
     end
end