local function FindAura(unit, spellID, filter)
    for i = 1, 100 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID = UnitAura(unit
            , i, filter)
        if not name then return nil end
        if spellID == auraSpellID then
            return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge,
                nameplateShowPersonal
                , auraSpellID
        end
    end
end

local function InitialisePetPet()
    local PetPetListener = CreateFrame("Frame")

    PetPetListener:RegisterEvent("PLAYER_STARTED_MOVING")

    PetPetListener:SetScript("OnEvent", function(self, event, ...)
        local summonedPetGUID = C_PetJournal.GetSummonedPetGUID()
        local canSummon = not UnitAffectingCombat("player")
            and not IsMounted() and not IsFlying() and not UnitHasVehicleUI("player")
            and not (UnitIsControlling("player") and UnitChannelInfo("player")) -- If player is mind-controlling
            and not IsStealthed()
            and not UnitIsGhost("player")
            and not FindAura("player", 199483, "HELPFUL") -- Camouflage
            and not FindAura("player", 32612, "HELPFUL") -- Invisibility
            and not FindAura("player", 110960, "HELPFUL") -- Greater Invisibility
            and C_PetJournal.HasFavoritePets() -- Player has favourite pets

        if summonedPetGUID == nil then
            if canSummon then
                C_PetJournal.SummonRandomPet(true)
            end
        end
    end)
end

local loadingEvents = CreateFrame("Frame")
loadingEvents:RegisterEvent("PLAYER_ENTERING_WORLD")

loadingEvents:SetScript(
    "OnEvent",
    function(_, event, arg1)
        if event == "PLAYER_ENTERING_WORLD" then
            InitialisePetPet()
            loadingEvents:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
    end
)
