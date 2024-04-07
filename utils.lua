function apply_properkorean()
    local is_korean = G.LANG.key == "ko"

    if is_korean then
        local mod_path = "Mods/ProperKorean/"
        local font_path = mod_path.."NotoSansKR-Bold.ttf"
        local lang_path = mod_path.."ko.lua"

        if G.F_NO_ACHIEVEMENTS then
            G.F_NO_ACHIEVEMENTS = false
        end

        for _, v in ipairs(G.FONTS) do
            if string.find(v.file, "KR") then
                v.file = font_path
                v.FONT = love.graphics.newFont(font_path, v.render_scale)

                break
            end
        end

        G.localization = assert(loadstring(love.filesystem.read(lang_path)))()
        init_localization()

        for _, v in pairs(G.CHALLENGES) do
            if v.id == "c_cruelty_1" then
                v.rules.custom[1].value = is_korean and "스몰" or "Small"
                v.rules.custom[2].value = is_korean and "빅" or "Big"

                break
            end
        end
    end
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

function korean_credits()
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