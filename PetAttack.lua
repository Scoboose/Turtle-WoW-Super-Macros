function petAttack()
    local playerName = UnitName("player");
    if UnitExists("target")
      then
        if a==0
          then
            PetAttack(target) a=1
          else
            if UnitExists("pettarget") and UnitIsUnit("target", "pettarget")
              then PetFollow(playerName) a=0
                else PetAttack(target)
            end
        end
    else PetFollow(playerName) a=0
    end
  end