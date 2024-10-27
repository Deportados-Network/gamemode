-- @vars
local fps = false

-- @commands
RegisterCommand('fps', function()
    fps = not fps

    if (fps) then
        SetTimecycleModifier('yell_tunnel_nodirect')
    else
        ClearTimecycleModifier()
    end
end)