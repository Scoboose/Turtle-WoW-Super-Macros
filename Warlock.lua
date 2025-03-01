-- Must have 3 addons installed
-- Quick Heal - https://github.com/Bestoriop/QuickHeal
-- CerniesWonderfulFunctions - https://github.com/Cernie/CerniesWonderfulFunctions
-- SuperMacro - https://github.com/Monteo/SuperMacro

-- Usage
-- If using a wand make sure the Shoot abbilty is on the bottom left bar slot one the farthest left. I plan to make it like my pally macro where it can be anywhere just have not got there yet
-- Adjust the configs below to your liking
-- Open super macro
-- Make a new macro
-- On the left add /script letsGo()
-- On the right paste this whole document in
-- Click save macro
-- Click Save Extended
-- Drag macro to bar
-- Have fun!

-- CONFIG --
-- Wand
UseWand = true
-- Buffs
DemonArmor = true
-- Pet
MakePetAttack = true
-- Utility
UseLifeTap = true
LifeTapHealth = 0.8 -- % of health needed to be above to use Life Tap
LifeTapMana = 0.8 -- % of mana needed to be below to use Life Tap
-- DOTs
UseImmolate = true
UseCorruption = true
-- Cureses Can only have 1 be true
UseCurseOfAgony = true -- this is in the dots function
UseCurseOfWeakness = false
UseCurseOfRecklessness = false
-- Spells
UseShadowBolt = true
ShadowBoltMana = 0.5 -- % of mana needed to cast Shadow Bolt
ShadowBoltTargetHealth = 0.1 -- % of health target needs to have to cat Shadow Bolt

-- Get Global Cool down
function WLGCD()
  if (UnitClass("player") == "Warlock") then
    return isSpellOnCd("Curse of Agony")
  end
end

function buffs()
  if not buffed("Demon Armor", "player") and (not WLGCD()) then
    CastSpellByName("Demon Armor")
  end
end

function pet()
  if UnitExists("target") and (MakePetAttack == true) then
    PetAttack(target)
  end
end

function utility()
  if (UnitHealth("player") / UnitHealthMax("player") > LifeTapHealth and UnitMana("player") / UnitManaMax("player") < LifeTapMana) and (not WLGCD()) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Life Tap")
  end
end

function cureses()
  if not (buffed("Curse of Weakness", "target")) and (UnitExists("target")) and (not WLGCD()) and (UseCurseOfWeakness == true) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Curse of Weakness")
  elseif not (buffed("Curse of Recklessness", "target")) and (UnitExists("target")) and (not WLGCD()) and (UseCurseOfRecklessness == true) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Curse of Recklessness")
  end
end

function dots()
  if not (buffed("immolate", "target")) and (UnitExists("target")) and (not WLGCD()) and (UseImmolate == true) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("immolate")
  elseif not (buffed("Curse of Agony", "target")) and (UnitExists("target")) and (not WLGCD()) and (UseCurseOfAgony == true) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Curse of Agony")
  elseif not (buffed("Corruption", "target")) and (UnitExists("target")) and (not WLGCD()) and (UseCorruption == true) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Corruption")
  end
end

function spells()
  if (UnitMana("player") / UnitManaMax("player") > ShadowBoltMana) and (UnitHealth("target") / UnitHealthMax("target") > ShadowBoltTargetHealth) and (not WLGCD()) then
    if IsCurrentAction(61) then
      SpellStopCasting()
    end
    CastSpellByName("Shadow Bolt")
  end
end

function wand()
  if not IsCurrentAction(61) and UnitExists("target") and (not WLGCD()) then
    UseAction(61)
  end
end

function WLStart()
  buffs()
  pet()
  utility()
  cureses()
  dots()
  spells()
  wand()
end