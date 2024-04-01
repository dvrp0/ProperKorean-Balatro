--- STEAMODDED HEADER
--- MOD_NAME: ProperKorean
--- MOD_ID: ProperKorean
--- MOD_AUTHOR: [Koreans]
--- MOD_DESCRIPTION: Fixes Korean translation to be proper

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.ProperKorean()
    G.F_NO_ACHIEVEMENTS = false

    local mod = SMODS.findModByID("ProperKorean")
    local font_path = mod.path.."NotoSansKR-Bold.ttf"
    local lang_path = mod.path.."ko.lua"

    local function apply_patch()
        local is_korean = G.LANG.key == "ko"
        if love.filesystem.exists(font_path) and love.filesystem.exists(lang_path) and is_korean then
            for _, v in ipairs(G.FONTS) do
                if string.find(v.file, "KR") then
                    v.file = font_path
                    v.FONT = love.graphics.newFont(font_path, v.render_scale)

                    break
                end
            end

            G.localization = assert(loadstring(love.filesystem.read(lang_path)))()
            init_localization()
        end

        for _, v in pairs(G.CHALLENGES) do
            if v.id == "c_cruelty_1" then
                v.rules.custom[1].value = is_korean and "스몰" or "Small"
                v.rules.custom[2].value = is_korean and "빅" or "Big"

                break
            end
        end
    end

    apply_patch()

    local set_language_ref = Game.set_language
    function Game:set_language()
        set_language_ref(self)
        apply_patch()
    end
end

-- Fix '보기 덱' to '덱 보기'
local draw_ref = CardArea.draw
function CardArea:draw()
    if not self.states.visible then return end 
    if G.VIEWING_DECK and (self==G.deck or self==G.hand or self==G.play) then return end

    if self == G.deck and not self.children.view_deck then
        local is_korean = G.LANG.key == "ko"
        self.children.view_deck = UIBox{
            definition = 
                {n=G.UIT.ROOT, config = {align = 'cm', padding = 0.1, r =0.1, colour = G.C.CLEAR}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.05, r =0.1, colour = adjust_alpha(G.C.BLACK, 0.5),func = "set_button_pip", focus_args = {button = "triggerright", orientation = "bm", scale = 0.6}, button = "deck_info"}, nodes={
                        {n=G.UIT.R, config={align = "cm", maxw = 2}, nodes={
                            {n=G.UIT.T, config={text = localize(is_korean and "k_deck" or "k_view"), scale = 0.48, colour = G.C.WHITE, shadow = true}}
                        }},
                        {n=G.UIT.R, config={align = "cm", maxw = 2}, nodes={
                            {n=G.UIT.T, config={text = localize(is_korean and "k_view" or "k_deck"), scale = 0.38, colour = G.C.WHITE, shadow = true}}
                        }},
                    }},
                }},
            config = { align = 'cm', offset = {x=0,y=0}, major = self.cards[1] or self, parent = self}
        }
        self.children.view_deck.states.collide.can = false
    end

    draw_ref(self)
end

local challenge_description_ref = G.UIDEF.challenge_description
function G.UIDEF.challenge_description(arg1, arg2, arg3)
    local description = challenge_description_ref(arg1, arg2, arg3)

    if G.LANG.key == "ko" then
        description.nodes[1].config.text = "도전을 선택하세요"
    end

    return description
end

local play_area_status_text_ref = play_area_status_text
function play_area_status_text(text, silent, delay)
    local is_korean = G.LANG.key == "ko" and text == "Not Allowed!"
    play_area_status_text_ref(is_korean and "허용되지 않음!" or text, silent, delay)
end

-- Fix '선택 x' to 'x장 선택'
local create_UIBox_arcana_pack_ref = create_UIBox_arcana_pack
function create_UIBox_arcana_pack()
    local is_korean = G.LANG.key == "ko"
    local choose = (is_korean and "장 " or "")..localize("k_choose")..(is_korean and "" or " ")
    local pack = {ref_table = G.GAME, ref_value = "pack_choices"}
    local t = create_UIBox_arcana_pack_ref()

    t.nodes[1].nodes[3].nodes[2].nodes = {
        UIBox_dyn_container({
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = localize("k_arcana_pack"), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}
                }},
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and pack or choose}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and choose or pack}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}
                }},
            }}
        })
    }

    return t
end

local create_UIBox_spectral_pack_ref = create_UIBox_spectral_pack
function create_UIBox_spectral_pack()
    local is_korean = G.LANG.key == "ko"
    local choose = (is_korean and "장 " or "")..localize("k_choose")..(is_korean and "" or " ")
    local pack = {ref_table = G.GAME, ref_value = "pack_choices"}
    local t = create_UIBox_spectral_pack_ref()

    t.nodes[1].nodes[3].nodes[2].nodes = {
        UIBox_dyn_container({
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = localize("k_spectral_pack"), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}
                }},
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and pack or choose}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and choose or pack}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}
                }},
            }}
        })
    }

    return t
end

local create_UIBox_standard_pack_ref = create_UIBox_standard_pack
function create_UIBox_standard_pack()
    local is_korean = G.LANG.key == "ko"
    local choose = (is_korean and "장 " or "")..localize("k_choose")..(is_korean and "" or " ")
    local pack = {ref_table = G.GAME, ref_value = "pack_choices"}
    local t = create_UIBox_standard_pack_ref()

    t.nodes[1].nodes[3].nodes[2].nodes = {
        UIBox_dyn_container({
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = localize("k_standard_pack"), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}
                }},
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and pack or choose}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and choose or pack}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}
                }},
            }}
        })
    }

    return t
end

local create_UIBox_buffoon_pack_ref = create_UIBox_buffoon_pack
function create_UIBox_buffoon_pack()
    local is_korean = G.LANG.key == "ko"
    local choose = (is_korean and "장 " or "")..localize("k_choose")..(is_korean and "" or " ")
    local pack = {ref_table = G.GAME, ref_value = "pack_choices"}
    local t = create_UIBox_buffoon_pack_ref()

    t.nodes[1].nodes[3].nodes[2].nodes = {
        UIBox_dyn_container({
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = localize("k_buffoon_pack"), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}
                }},
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and pack or choose}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and choose or pack}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}
                }},
            }}
        })
    }

    return t
end

local create_UIBox_celestial_pack_ref = create_UIBox_celestial_pack
function create_UIBox_celestial_pack()
    local is_korean = G.LANG.key == "ko"
    local choose = (is_korean and "장 " or "")..localize("k_choose")..(is_korean and "" or " ")
    local pack = {ref_table = G.GAME, ref_value = "pack_choices"}
    local t = create_UIBox_celestial_pack_ref()

    t.nodes[1].nodes[3].nodes[2].nodes = {
        UIBox_dyn_container({
            {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = localize("k_celestial_pack"), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}
                }},
                {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and pack or choose}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                    {n=G.UIT.O, config={object = DynaText({string = {is_korean and choose or pack}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}
                }},
            }}
        })
    }

    return t
end

-- Fix '2X 칩 기본' to '기본 칩의 2배'
function create_UIBox_blind_popup(blind, discovered, vars)
    local is_korean = G.LANG.key == "ko"
    local blind_text = {}
    local ox_vars = is_korean and blind.key == "bl_ox" and {blind.vars[1].."를"} or nil

    local _dollars = blind.dollars
    local loc_target = localize{type = 'raw_descriptions', key = blind.key, set = 'Blind', vars = vars or ox_vars or blind.vars}
    local loc_name = localize{type = 'name_text', key = blind.key, set = 'Blind'}
  
    if discovered then 
      local ability_text = {}
      if loc_target then 
        for k, v in ipairs(loc_target) do
          ability_text[#ability_text + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = (k ==1 and blind.name == 'The Wheel' and '1' or '')..v, scale = 0.35, shadow = true, colour = G.C.WHITE}}}}
        end
      end
      local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.4)
      blind_text[#blind_text + 1] =
        {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.07, colour = G.C.WHITE}, nodes={
          {n=G.UIT.R, config={align = "cm", maxw = 2.4}, nodes={
            {n=G.UIT.T, config={text = localize('ph_blind_score_at_least'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
          }},
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text = is_korean and localize('k_x_base_1') or '', scale = 0.4, colour = G.C.RED}},
            {n=G.UIT.O, config={object = stake_sprite}},
            {n=G.UIT.T, config={text = is_korean and (localize('k_x_base_2')..blind.mult..localize('k_x_base_3')) or blind.mult..localize('k_x_base'), scale = 0.4, colour = G.C.RED}},
          }},
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text = localize('ph_blind_reward'), scale = 0.35, colour = G.C.UI.TEXT_DARK}},
            {n=G.UIT.O, config={object = DynaText({string = {_dollars and string.rep(localize('$'),_dollars) or '-'}, colours = {G.C.MONEY}, rotate = true, bump = true, silent = true, scale = 0.45})}},
          }},
          ability_text[1] and {n=G.UIT.R, config={align = "cm", padding = 0.08, colour = mix_colours(blind.boss_colour, G.C.GREY, 0.4), r = 0.1, emboss = 0.05, minw = 2.5, minh = 0.9}, nodes=ability_text} or nil
        }}
    else
      blind_text[#blind_text + 1] =
        {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.1, colour = G.C.WHITE}, nodes={
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text = localize('ph_defeat_this_blind_1'), scale = 0.4, colour = G.C.UI.TEXT_DARK}},
          }},
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text = localize('ph_defeat_this_blind_2'), scale = 0.4, colour = G.C.UI.TEXT_DARK}},
          }},
        }}
    end
   return {n=G.UIT.ROOT, config={align = "cm", padding = 0.05, colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, emboss = 0.05}, nodes={
    {n=G.UIT.R, config={align = "cm", emboss = 0.05, r = 0.1, minw = 2.5, padding = 0.1, colour = not discovered and G.C.JOKER_GREY or blind.boss_colour or G.C.GREY}, nodes={
      {n=G.UIT.O, config={object = DynaText({string = discovered and loc_name or localize('k_not_discovered'), colours = {G.C.UI.TEXT_LIGHT}, shadow = true, rotate = not discovered, spacing = discovered and 2 or 0, bump = true, scale = 0.4})}},
    }},
    {n=G.UIT.R, config={align = "cm"}, nodes=blind_text},
   }}
end

-- Fix Orbital Tag's poker hand name to be translated
local update_hand_text_ref = update_hand_text
function update_hand_text(config, vals)
    if vals.handname and G.LANG.key == "ko" then
        for _, v in pairs(G.handlist) do
            if vals.handname == v then
                vals.handname = localize(vals.handname, "poker_hands")

                break
            end
        end
    end

    update_hand_text_ref(config, vals)
end

function get_josa_for_rank(rank)
    local eul = {"3", "6", "7", "8", "10", "잭", "퀸", "킹"}

    for _, v in pairs(eul) do
      if v == rank then
        return "을"
      end
    end

    return "를"
end

function get_josa_for_poker_hand(hand)
    return hand == "트리플" and "을" or "를"
end

-- Apply appropriate josa to card/tag/blind descriptions
local generate_card_ui_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    if G.LANG.key == "ko" and card_type ~= "Locked" and card_type ~= "Undiscovered" then
        if _c.name == "The Idol" or _c.name == "Mail-In Rebate" then
            table.insert(specific_vars, get_josa_for_rank(specific_vars[2]))
        elseif _c.name == "Orbital Tag" then
            table.insert(specific_vars, get_josa_for_poker_hand(specific_vars[1]))
        end
    end

    return generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
end

local create_UIBox_blind_choice_ref = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local t = create_UIBox_blind_choice_ref(type, run_info)

    if G.LANG.key == "ko" and t.nodes[1].nodes[3].nodes[1].nodes[1].nodes[2] ~= nil and t.nodes[1].nodes[3].nodes[1].nodes[1].nodes[2].nodes[1] ~= nil then
        local hand = localize(G.GAME.current_round.most_played_poker_hand, "poker_hands")
        t.nodes[1].nodes[3].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].config.text = string.gsub(
            t.nodes[1].nodes[3].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].config.text, hand, hand..get_josa_for_poker_hand(hand)
        )
    end

    return t
end

local set_text_ref = Blind.set_text
function Blind:set_text()
    set_text_ref(self)

    if G.LANG.key == "ko" and self.name == "The Ox" and self.loc_debuff_text ~= "" then
        local hand = localize(G.GAME.current_round.most_played_poker_hand, "poker_hands")
        local hand_josa = hand..get_josa_for_poker_hand(hand)
        self.loc_debuff_text = string.gsub(self.loc_debuff_text, hand, hand_josa)
        self.loc_debuff_lines[1] = string.gsub(self.loc_debuff_lines[1], hand, hand_josa)
    end
end

-- Translate credits
local credits_ref = G.UIDEF.credits
function G.UIDEF.credits()
    if G.LANG.key ~= "ko" then
        return credits_ref()
    end

    local text_scale = 0.75
    local t = create_UIBox_generic_options({contents ={
        {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
          create_tabs(
          {tabs = {
            {
              label = "음악",
              chosen = true,
              tab_definition_function = function() return 
                {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 6}, nodes={
                  {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                    {n=G.UIT.T, config={text = "오리지널 사운드트랙", scale = text_scale*0.8, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                  }},
                  {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                    {n=G.UIT.T, config={text = "LouisF", scale = text_scale*0.8, colour = G.C.BLUE, shadow = true}},
                    {n=G.UIT.T, config={text = " 작곡", scale = text_scale*0.8, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                  }},
                  G.F_EXTERNAL_LINKS and {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                    UIBox_button({label = {'인스타그램'}, button = 'louisf_insta'})
                  }} or nil,
                  {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
                    {n=G.UIT.T, config={text = "허가를 받아 수정함", scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                  }},
                }}
              end,
            },
              {
                label = "기타",
                tab_definition_function = function() return 
                  {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 6}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "For Marshal", scale = text_scale*0.6, colour = G.C.WHITE, shadow = true}},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "감사한 분들", scale = text_scale*0.6, colour = G.C.GREEN, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                        {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Nicole', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Josh', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Jeremy', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Dylan', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Justin', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Daniel', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Colby', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Thomas', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Mom & Dad', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Luc & Donna', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                        }},
                        {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'GothicLordUK', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Big Simple', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'MALF', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Northernlion', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Purple Moss Collectors', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Dan Gheesling', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Fabian Fischer', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'newobject', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'MurphyObv', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Love2D', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                        }},
                      }},
                    }}
                  }}
                end,
              },
              {
                label = "프로덕션",
                tab_definition_function = function() return 
                  {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "퍼블리싱", scale = text_scale*0.6, colour = G.C.WHITE, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "Playstack", scale = text_scale*0.6, colour = G.C.RED, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                        {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Harvey Elliot', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Kevin Shrapnell', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Rob Crossley', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Liz Cheng-Moore', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Charlotte Riley', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Alexander Saunders', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Naman Budhwar', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Tomasz Wisniowski', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Patrick Johnson', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Wout van Halderen', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Shawn Cotter', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Marta Matyjewicz', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Krzysztof Niedzielski', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Rebecca Bell', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                        }},
                        {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Jose Olivares', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Alex Flynn', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Justas Pugaciauskas', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Jessica Chu', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Millicent Su', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Carla Malavasi', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Pawel Kwietniak', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Ela Müller', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Fox Hambly', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Edgar Khoo', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Dami Ajiboye', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Jean Claude Vidanes', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Joanna Kierońska', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                        }},
                      }},
                    }},
                    {n=G.UIT.C, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "현지화", scale = text_scale*0.6, colour = G.C.WHITE, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "Universally Speaking", scale = text_scale*0.6, colour = G.C.FILTER, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                        {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '독일어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '라틴아메리카 스페인어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '프랑스어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '인도네시아어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '이탈리아어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '일본어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '한국어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '네덜란드어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '폴란드어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '브라질 포르투갈어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '러시아어', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '중국어 간체', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '중국어 번체', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = '프로젝트 관리자', scale = text_scale*0.35, colour = G.C.FILTER, shadow = true}},
                          }},
                        }},
                        {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Dominik May, Lisa-Marie Beck', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Román René Orozco, Javier Gómez', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Romain Vervaecke, Claire Gérard', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Yopi Jalu Paksi, Sutarto Mohammad', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Oliver Cozzio, Giulia Benassi', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Takashi Fujimoto, Ai Parlow', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Haejung Lee, Sanghyun Bae', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Ellis Jongsma, Erik Nusselder', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Mariusz Wlodarczyk, Bartosz Klofik', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Samuel Modesto, R. Cali', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Yuliia Tatsenko, Natalia Rudane', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Shuai Fang, Liqi Ye', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Pauline Lin, AngelRabbitBB', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                            {n=G.UIT.T, config={text = 'Ruoyang Yuan, Tania Carè', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                          }},
                        }},
                      }},
                    }},
                    {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                      {n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                        {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                          {n=G.UIT.T, config={text = "포팅", scale = text_scale*0.6, colour = G.C.WHITE, shadow = true}},
                        }},
                        (love.system.getOS() == 'Nintendo Switch') and {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                          {n=G.UIT.T, config={text = "Platform help", scale = text_scale*0.45, colour = G.C.GOLD, shadow = true}},
                        }} or {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                          {n=G.UIT.T, config={text = "Xbox 및 PlayStation", scale = text_scale*0.45, colour = G.C.GOLD, shadow = true}},
                        }},
                        {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                          {n=G.UIT.C, config={align = "tl", padding = 0.03}, nodes={
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'Maarten De Meyer', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                          }},
                        }},
                        (love.system.getOS() ~= 'Nintendo Switch') and {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                          {n=G.UIT.T, config={text = "Mac", scale = text_scale*0.45, colour = G.C.GOLD, shadow = true}},
                        }} or nil,
                        {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                          {n=G.UIT.C, config={align = "tl", padding = 0.03}, nodes={
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'william341', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                          }},
                        }},
                      }},
                      {n=G.UIT.R, config={align = "tm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                        {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                          {n=G.UIT.T, config={text = "테스트/QA", scale = text_scale*0.6, colour = G.C.WHITE, shadow = true}},
                        }},
                        {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                          {n=G.UIT.C, config={align = "tl", padding = 0.03}, nodes={
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'Vishwak Kondapalli', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'Basha Syed', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'CampfireCollective', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'drspectred', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'TheRealEvab', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'Brightqwerty', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'MrWizzrd', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                              {n=G.UIT.T, config={text = 'mcpower', scale = text_scale*0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
                          }},
                        }},
                      }},
                    }}
                  }}
                end,
              },
              {
                label = "음향",
                tab_definition_function = function() return 
                  {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                      {n=G.UIT.T, config={text = "이곳에 언급되지 않은 모든 음향 리소스는 ", scale = text_scale*0.6, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      {n=G.UIT.T, config={text = "크리에이티브 커먼즈 - CC0", scale = text_scale*0.6, colour = G.C.BLUE, shadow = true}},
                      {n=G.UIT.T, config={text = " 라이센스를 따릅니다", scale = text_scale*0.6, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'uair01 (https://freesound.org/people/uair01/sounds/65195/) 이 제작한 "chamber_choir_chord_o.wav" (폴리크롬 효과에 사용됨) 는', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "저작자표시 3.0 라이센스", scale = text_scale*0.5, colour = G.C.GOLD, shadow = true}},
                        {n=G.UIT.T, config={text = '를 따릅니다.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n=G.UIT.T, config={text = ' 원본 상태에서 수정을 거쳐 사용되었습니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'Nathan Gibson (https://nathangibson.myportfolio.com) 이 제작한 "Coffee1.wav" (타로 카드 효과에 사용됨) 는', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "저작자표시 4.0 라이센스", scale = text_scale*0.5, colour = G.C.ORANGE, shadow = true}},
                        {n=G.UIT.T, config={text = '를 따릅니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n=G.UIT.T, config={text = '.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'Nathan Gibson (https://nathangibson.myportfolio.com) 이 제작한 "Wood Block1.wav" (타로 카드 효과에 사용됨) 는', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "저작자표시 4.0 라이센스", scale = text_scale*0.5, colour = G.C.ORANGE, shadow = true}},
                        {n=G.UIT.T, config={text = '를 따릅니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n=G.UIT.T, config={text = '.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'poissonmort (https://freesound.org/people/poissonmort/sounds/253249/) 이 제작한 "Toy records#06-E3-02.wav" (배수 효과에 사용됨) 은', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "저작자표시 4.0 라이센스", scale = text_scale*0.5, colour = G.C.ORANGE, shadow = true}},
                        {n=G.UIT.T, config={text = '를 따릅니다.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n=G.UIT.T, config={text = ' 원본 상태에서 수정을 거쳐 사용되었습니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                    }},
                  }}
                end,
              },
              {
                label = "시각",
                tab_definition_function = function() return 
                  {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                      {n=G.UIT.T, config={text = "이곳에 언급되지 않은 모든 스프라이트, 셰이더 및", scale = text_scale*0.6, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                      {n=G.UIT.T, config={text = "기타 비주얼 에셋은 LocalThunk가 제작했습니다.", scale = text_scale*0.6, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                      {n=G.UIT.T, config={text = "©2024 - All rights reserved", scale = text_scale*0.6, colour = G.C.BLUE, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'Daniel Linssen (https://managore.itch.io/m6x11) 가 제작한 폰트 "m6x11.ttf"는', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = "저작자표시 라이센스", scale = text_scale*0.5, colour = G.C.GOLD, shadow = true}},
                        {n=G.UIT.T, config={text = '를 따릅니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n=G.UIT.T, config={text = '.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                      not G.F_BASIC_CREDITS and 
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'Daniel의 itch.io 프로필을 확인해 보세요. 굉장한 게임들로 가득합니다.', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }} or nil,
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1,outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = '"방랑자" 조커는 Lumpy Touch가 제작했습니다', scale = text_scale*0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                      }},
                    }},
                  }}
                end,
              },
          },
          snap_to_nav = true}),
        }}
    }})
    return t
end

----------------------------------------------
------------MOD CODE END----------------------