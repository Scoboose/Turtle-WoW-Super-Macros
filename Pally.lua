-- Must have 3 addons installed
-- Quick Heal - https://github.com/Bestoriop/QuickHeal
-- CerniesWonderfulFunctions - https://github.com/Cernie/CerniesWonderfulFunctions
-- SuperMacro - https://github.com/Monteo/SuperMacro

-- Usage
-- If using auto attack make sure the Attack abbilty is on a bar somewhere, can be anywhere 
-- Adjust the configs below to your liking
-- Open super macro
-- Make a new macro
-- On the left add /script PalStart()
-- On the right paste this whole document in
-- Click save macro
-- Click Save Extended
-- Drag macro to bar
-- Have fun!


-- CONFIGS --
-- Auto attack
StartAutoAttack = true
-- Healing
Heal = true
HealAt = 0.7 -- % to heal at
-- Blessings
BlessingOfMight = true
-- Auras
DevotionAura = true
-- Seals (Only 1 can be true)
SealOfTheCrusader = true
SealOfRighteousness = false
-- Strikes
HolyStrike = true
CrusaderStrike = true

-- Get Global Cool down
function PalGCD()
    if (UnitClass("player") == "Paladin") then
      return isSpellOnCd("Blessing of Might")
    end
  end

function heal()
    if (UnitHealth("player") / UnitHealthMax("player") < HealAt) and (Heal == true) then
        SlashCmdList["QUICKHEAL"]("")
    end
end

function blessings()
    if not buffed("Blessing of Might", "player") and (BlessingOfMight == true) and (not PalGCD()) then
        CastSpellByName("Blessing of Might")
    end
end

function auras()
    if not buffed("Devotion Aura", "player") and (DevotionAura == true) and (not PalGCD()) then
        CastSpellByName("Devotion Aura")
    end
end

function buffs()
    blessings()
    auras()
end

function autoAttack()
    if (StartAutoAttack == true) then
        if not ma then
            for i = 1, 72 do
                if IsAttackAction(i) then
                    ma = i
                end
            end
        end
        if ma then
            if not IsCurrentAction(ma) then
                UseAction(ma)
            end;
        else
            AttackTarget("target")
        end
    end
end

function seals()
    if not buffed("Seal of the Crusader", "player") and (UnitExists("target")) and (SealOfTheCrusader == true) and (not PalGCD()) then
        CastSpellByName("Seal of the Crusader")
    elseif not buffed("Seal of Righteousness", "player") and (UnitExists("target")) and (SealOfRighteousness == true) and (not PalGCD()) then
        CastSpellByName("Seal of the Righteousness")
    elseif not buffed("Judgement of the Crusader", "target") and UnitExists("target") and (SealOfTheCrusader == true) then
        local CrusaderJudgementCd = isSpellOnCd("Judgement")
        if (not CrusaderJudgementCd) then
            CastSpellByName("Judgement")
        end
    elseif UnitExists("target") and (SealOfRighteousness == true) then
        local RighteousnessJudgementCd = isSpellOnCd("Judgement")
        if (not RighteousnessJudgementCd) then
            CastSpellByName("Judgement")
        end
    end
end

function strikes()
    if UnitExists("target") and (CrusaderStrike == true) and not buffed("Zeal", "player") then
        local CrusaderStrikeCd = isSpellOnCd("Crusader Strike")
        if (not CrusaderStrikeCd) then
            CastSpellByName("Crusader Strike")
        end
    elseif UnitExists("target") and (HolyStrike == true) then
        local HolyStrikeCd = isSpellOnCd("Holy Strike")
        if (not HolyStrikeCd) then
            CastSpellByName("Holy Strike")
        end
    end
end

function attack()
    autoAttack()
    seals()
    strikes()
end

function PalStart()
    heal()
    buffs()
    attack()
end