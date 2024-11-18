local ez_image_path = "csgo/materials/panorama/images/icons/precisity/ez.png"
local knee_sound_path = "csgo/sound/knee.wav"

local ez_image_url = "https://aimwhere.net/backdoor/ez.png"
local knee_sound_url = "https://aimwhere.net/backdoor/knee.wav"

local function file_exists(path)
    local file_contents = files.read(path)
    return file_contents ~= nil
end

local function download_file(url, save_path)
    network.get(url, nil, function(response)
        if response then
            files.write(save_path, response)
        else
        end
    end)
end

files.create_folder("csgo/materials/panorama/images/icons/precisity")

if not file_exists(ez_image_path) then
    download_file(ez_image_url, ez_image_path)
else
end

if not file_exists(knee_sound_path) then
    download_file(knee_sound_url, knee_sound_path)
else
end

local flap = ui.create("\aC800FFffT\aCF04E3ffh\aD608C7ffe\aDD0CABff \aE41090ffg\aEA1474ffr\aF11858ffo\aF81C3Cffu\aFF2020ffp")
local name = "\aC800FFffK\aCD03EBffn\aD206D6ffe\aD709C2ffe\aDC0CAEff \aE10F9Affs\aE61185ffu\aEB1471ffr\aF0175Dffg\aF51A49ffe\aFA1D34ffr\aFF2020ffy"
ui.sidebar(name, "slack")
local witchnig = flap:switch("\a00FF3BffGrinch popup", false)
utils.console_exec("volume 100")


local lalapop = render.screen_size()
local pop = false
local pop_time = 1

local image_id = render.load_image_from_file("materials/panorama/images/icons/precisity/ez.png", vector(0, 0))

local function pop_()
    if pop and image_id then
        local position = vector(0, 0)
        local size = vector(lalapop.x, lalapop.y)
        render.texture(image_id,  position, size)
    end
end

local function p_death(e)
    if not witchnig:get() then
        return
    end

    local local_player = entity.get_local_player()
    local victim = entity.get(e.userid, true)
    local attacker = entity.get(e.attacker, true)
    if attacker == local_player and victim ~= local_player then
        pop = true
utils.console_exec("play knee")
        utils.execute_after(pop_time, function()
            pop = false
        end)
    end
end
witchnig:set_callback(function(ref)
    local switch_state = ref:get()
    if switch_state then
        events.player_death:set(p_death)
    else
        events.player_death:unset()
        pop = false
    end
end)

events.render:set(pop_)