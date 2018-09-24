local function hotTerminal() hs.application.launchOrFocus("Terminal") end
local function hotChrome() hs.application.launchOrFocus("Google Chrome") end
local function hotDiscord() hs.application.launchOrFocus("Discord") end
local function hotItunes() hs.application.launchOrFocus("iTunes") end
local function hotFinder() hs.application.launchOrFocus("Finder") end
hs.hotkey.bind({"ctrl"}, "i", function() hotTerminal() end)
hs.hotkey.bind({"ctrl"}, "y", function() hotItunes() end)
hs.hotkey.bind({"ctrl"}, ";", function() hotChrome() end)
hs.hotkey.bind({"ctrl"}, "'", function() hotDiscord() end)
hs.hotkey.bind({"ctrl"}, "o", function() hotFinder() end)

pass = {}
default = {}

appKeyMappers = {
    ["Terminal"] = pass,
    ["Finder"] = {
        {{'ctrl'}, 'h', {}, 'left'},
        {{'ctrl'}, 'l', {}, 'right'},
        {{'ctrl'}, 'j', {}, 'down'},
        {{'ctrl'}, 'k', {}, 'up'},
    },
    ["Google Chrome"] = {
        {{'ctrl'}, 'h', {}, 'left'},
        {{'ctrl'}, 'l', {}, 'right'},
        {{'ctrl'}, 'j', {}, 'down'},
        {{'ctrl'}, 'k', {}, 'up'},
        {{'ctrl'}, 'w', {'alt'}, 'delete'}
    },
    ["Microsoft Excel"] = default,
}

delay = hs.eventtap.keyRepeatDelay()
interval = hs.eventtap.keyRepeatInterval()

function bindKeyMappers(keyMappers,modal)
    for i,mapper in ipairs(keyMappers) do
        modal:bind(mapper[1], mapper[2], function()
            modal.triggered = true
            hs.eventtap.keyStroke(mapper[3],mapper[4], delay )
        end, nil, function()
        hs.eventtap.keyStroke(mapper[3],mapper[4], interval )
    end)
end
    return modal
end

appKeyModals = {
    [0] = hs.hotkey.modal.new( pass, nil ),
    [1] = bindKeyMappers( default, hs.hotkey.modal.new({}, nil ) )
}

modal = appKeyModals[1]
modal:enter()

function app(name, e, obj)
    if e == hs.application.watcher.activated then
        modal:exit()
        useDefault = true
        keyMappers = appKeyMappers[name]

        if( keyMappers == nil ) then
            keyMappers = appKeyMappers[name.."*"]
        else
            useDefault = false
        end

        if( keyMappers == nil ) then
            modal = appKeyModals[1]
        else
            modal = appKeyModals[name]
            if( modal == nil ) then
                if( keyMappers == pass ) then
                    modal = appKeyModals[0]
                elseif( keyMappers == default ) then
                    modal = appKeyModals[1]
                else
                    modal = hs.hotkey.modal.new({}, nil )
                    if( useDefault ) then
                        hs.alert("hoge")
                        bindKeyMappers(default, modal )
                    end
                    bindKeyMappers(keyMappers, modal )
                end
                appKeyModals[name] = modal
            end
        end
        modal:enter()
    end
end

Watcher = hs.application.watcher.new(app)
Watcher:start()
