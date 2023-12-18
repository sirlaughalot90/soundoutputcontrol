-- Binden Sie eine Taste, um zwischen den Soundausgabe-Geräten zu wechseln, aber ignorieren Sie "Microsoft Teams Audio"
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", function()
    local devices = hs.audiodevice.allOutputDevices()
    local current_device = hs.audiodevice.defaultOutputDevice()
    local next_device
    local skip_device_name = "Microsoft Teams Audio" -- Name des zu ignorierenden Geräts

    for i, device in ipairs(devices) do
        if device:name() == skip_device_name then
            -- Überspringe das "Microsoft Teams Audio" Gerät
        elseif current_device:uid() == device:uid() then
            -- Finde das nächste Gerät, das nicht Microsoft Teams Audio ist
            repeat
                i = (i % #devices) + 1
                next_device = devices[i]
            until next_device:name() ~= skip_device_name
            break
        end
    end

    if next_device then
        next_device:setDefaultOutputDevice()
        hs.alert.show("Soundausgabe: " .. next_device:name())
    else
        hs.alert.show("Kein alternativer Soundausgang gefunden.")
    end
end)
