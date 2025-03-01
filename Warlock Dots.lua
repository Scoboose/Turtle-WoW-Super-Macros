--[[ Start of comments
Action Bar Slots:
1 - 12 : Action Bar 1
13 - 24 : Action Bar 2
25 - 36 : Action Bar 3 (Right)
37 - 48 : Action Bar 4 (Right-2)
49 - 60 : Action Bar 5 (Bottom Right)
61 - 72 : Action Bar 6 (Bottom Left)
73 - 84 : Battle Stance (Warrior) or Stealth (Rogue)
85 - 96 : Defensive Stance (Warrior)
97 - 108 : Berserker Stance (Warrior)

/script buffPetAttack()
/script dots()

End of comments ]]

function buffPetAttack()
  if not buffed("Demon Armor", "player") then
    CastSpellByName("Demon Armor")
  elseif UnitExists("target") then
    --print("Sending pet to attack")
    PetAttack(target)
  end
end

function dots()
  local GCD = isSpellOnCd("Curse of Agony")
  if not buffed("immolate", "target") and UnitExists("target") and (not GCD) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    --print("Casting Immolate")
    CastSpellByName("immolate")
  elseif not buffed("Curse of Agony", "target") and UnitExists("target") and (not GCD) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    --print("Casting Curse of Agony")
    CastSpellByName("Curse of Agony")
  elseif not buffed("Corruption", "target") and UnitExists("target") and (not GCD) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    --print("Casting Corruption")
    CastSpellByName("Corruption")
  elseif (UnitHealth("player") / UnitHealthMax("player") > 0.8 and UnitMana("player") / UnitManaMax("player") < 0.8) and (not GCD) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Life Tap")
  elseif (UnitMana("player") / UnitManaMax("player") > 0.5) and (UnitHealth("target") / UnitHealthMax("target") > 0.1) and (not GCD) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    --print("Casting Shadow Bolt")
    CastSpellByName("Shadow Bolt")
  elseif not IsCurrentAction(61) and UnitExists("target") and (not GCD) then
    --print("Starting wand")
    UseAction(61)
  end
end
