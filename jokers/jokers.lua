
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

SMODS.Atlas({
    key = "tipito",
    path = "j_tipito.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "tipito",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },    
    pools = {["LRRmodAddition"] = true},                     
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'tipito',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3 or context.other_card:get_id() == 6 then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.95)
                    G.GAME.blind.chip_text = G.GAME.blind.chips
                    return{
                        extra = { focus = card, message = "All y'all high refresh players who think Sonic Wave is easier then Erebus, first of all shut the fuck up and 2nd of all of the wave plays by itself for you guys."}
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "hpsk",
    path = "j_hpsk.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "hpsk",                                  
    config = { extra = {x_chips = 1.5, chance = 10, message = "Site is ok", color = G.C.GREEN } },                
    pos = { x = 0, y = 0 },              
    pools = {["LRRmodAddition"] = true},           
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'hpsk',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            return{
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
        if context.destroying_card and (not context.blueprint) then
            for k, v in ipairs(context.scoring_hand) do
                if pseudorandom('hpsk') < G.GAME.probabilities.normal/card.ability.extra.chance then
                    card.ability.extra.message = 'Site crashed'
                    card.ability.extra.color = G.C.RED
                    return not SMODS.is_eternal(context.destroying_card)
                end
            end
        end
        if context.before and (not context.blueprint) then
            card.ability.extra.message = 'Site is ok'
            card.ability.extra.color = G.C.GREEN
        end
        if context.after and (not context.blueprint) then
            return{
                message = card.ability.extra.message,
                colour = card.ability.extra.color,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "dominionxx",
    path = "j_dominionxx.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "dominionxx",                                  
    config = { extra = { x_mult = 1, x_mult_mod = 0.5 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'dominionxx',                                

    calculate = function(self,card,context)
        if G.playing_cards and (not context.blueprint) then
            card.ability.extra.x_mult = 1 + math.floor(#G.playing_cards / 12) * card.ability.extra.x_mult_mod
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "nejus",
    path = "j_nejus.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "nejus",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'nejus',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers then
            if context.before then
                if context.scoring_name == 'Flush' or context.scoring_name == 'Straight Flush' and (not context.blueprint) then
                    local cards = {}
                    for k, v in ipairs(context.scoring_hand) do
                        if not v:is_suit('Spades') then 
                            cards[#cards+1] = v
                            v:change_suit('Spades')
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:juice_up()
                                    return true
                                end
                            })) 
                        end
                    end
                    if #cards > 0 then 
                        return {
                            message = "Monkey'd",
                            colour = G.C.BLACK,
                            card = card
                        }
                    end
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "shrek",
    path = "j_shrek.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "shrek",                                  
    config = { extra = { x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 10,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'shrek',                                

    calculate = function(self,card,context)
        if context.remove_playing_cards and (not context.blueprint) then
            local spades = 0;
            for k, v in ipairs(context.removed) do
                if v:is_suit("Spades") then spades = spades + 1 end
            end
            if spades > 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + spades * 0.5
                 G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}}}); return true
                    end}))
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult}  }
    end
}

SMODS.Atlas({
    key = "hombie",
    path = "j_hombie.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "hombie",                                  
    config = { extra = { mult = 0 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'hombie',                                

    calculate = function(self,card,context)
        if context.discard and context.other_card:get_id() == 12 and (not context.blueprint) then
            if not context.other_card.debuff then
                card.ability.extra.mult = card.ability.extra.mult + 2
                return {
                    message = 'Bye Bye Queen',
                    card = card,
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers and (card.ability.extra.mult > 0) then
            return{
                mult = card.ability.extra.mult,
                card = card,
                colour = G.C.MULT
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end
}

SMODS.Atlas({
    key = "theo",
    path = "j_theonec.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "theo",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 8,                                        
    blueprint_compat=false,                             
    eternal_compat=false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'theo',                                

    calculate = function(self,card,context)
        if context.selling_self and (not context.blueprint) then
            local seals = {'Red', 'Blue', 'Gold', 'Purple', 'lrr_plus_seal', 'lrr_ulrr_seal'}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].seal == nil then
                    G.hand.cards[i].seal = seals[math.random(1,6)]
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "pigeons",
    path = "j_pigeons.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "pigeons",                                  
    config = { },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 10,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'pigeons',                                

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "lrr_ulrr_seal" then 
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 2,
                        card = card,
                    }
            end
        end

        if context.cardarea == G.play and context.individual and #G.play.cards == 1 and G.GAME.current_round.hands_played == 0 and (not context.blueprint) then
            context.other_card.seal = "lrr_ulrr_seal"
        end
    end;

    loc_vars = function(self, info_queue, card)
        return {  }
    end
}

SMODS.Atlas({
    key = "iconic",
    path = "j_iconic.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "iconic",                                  
    config = {},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'iconic',                                

    calculate = function(self,card,context)
        if context.end_of_round and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if G.ARGS.chip_flames.real_intensity > 0.000001 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local carde = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                carde:add_to_deck()
                                G.consumeables:emplace(carde)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                        return true
                    end)}))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local carde = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                carde:add_to_deck()
                                G.consumeables:emplace(carde)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.BLUE})                       
                        return true
                    end)}))
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Sound({key = "bsod", path = "BSOD.ogg"})
SMODS.Atlas({
    key = "samamba",
    path = "j_samamba.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "samamba",                                  
    config = { extra = { x_mult = 2, x_chips = 2, chance = 6} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'samamba',                                

    calculate = function(self,card,context)
        if context.before and (not context.blueprint) then
            if pseudorandom('samamba') < G.GAME.probabilities.normal/card.ability.extra.chance then
                showCrash()
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "pryanik",
    path = "j_pryanik.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "pryanik",                                  
    config = { extra = { chance = 5, chance2 = 10 }},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 12,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'pryanik',                                

    calculate = function(self,card,context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card.edition and context.other_card.edition.type == "negative" then
                local amount = 1
                if pseudorandom('pryanik') < G.GAME.probabilities.normal/card.ability.extra.chance then
                    amount = amount + 1
                end
                if pseudorandom('pryanik') < G.GAME.probabilities.normal/card.ability.extra.chance2 then
                    amount = amount + 1
                end
                return {
                    extra = { focus = card, message = localize('k_again_ex')},
                    repetitions = amount,
                    card = card
                }
            else
                return nil, true end
		end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {(G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "biprex",
    path = "j_biprex.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "biprex",                                  
    config = { extra = { chips = 1395 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 20,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'biprex',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips,
                card = card,
                colour = G.C.CHIPS
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips} }
    end
}

SMODS.Atlas({
    key = "tactical",
    path = "j_tactical.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "tactical",                                  
    config = { extra = {payout = 10}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 8,                                        
    blueprint_compat=false,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'tactical',                                

    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and (not context.blueprint) then
            if G.GAME.blind.boss then
                if card.ability.extra.payout == 2 then
                    G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(card)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                end
                            }))
                    return {
                        message = 'Tax Evasion',
                        colour = G.C.MONEY
                    }
                else 
                    card.ability.extra.payout = card.ability.extra.payout - 2
                    return {
                        message = 'Rent is due...',
                        colour = G.C.MONEY
                    }
                end
            end 
        end
    end;

    calc_dollar_bonus = function(self,card)
        return card.ability.extra.payout
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout}}
    end
}

SMODS.Atlas({
    key = "truebolt",
    path = "j_truebolt.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "truebolt",                                  
    config = { extra = { x_chips = 1.2 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'truebolt',                                

    calculate = function(self,card,context)
        if not context.end_of_round then
            if context.cardarea == G.hand and context.individual and context.other_card:get_id() == 12 then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        x_chips = card.ability.extra.x_chips,
                        card = card
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "jollow",
    path = "j_jollow.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "jollow",                                  
    config = { extra = {dollars = 1}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'jollow',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == 'Default Base' then
                return {
                    dollars = card.ability.extra.dollars,
                    card = card,
                    colour = G.C.MONEY
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars} }
    end
}

SMODS.Atlas({
    key = "cejelost",
    path = "j_cejelost.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cejelost",                                  
    config = { extra = { mult = 10, chips = 50, dollars = 2, x_mult = 1.2, x_chips = 1.2, chance = 5}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 8,                                        
    blueprint_compat=false,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cejelost',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers and (not context.blueprint) then
            local choice = math.random(1,5)
            local effectMult = 1
            if pseudorandom('cejelost') < G.GAME.probabilities.normal/card.ability.extra.chance then
                effectMult = 10
            end

            local cejeMessage
            if effectMult == 10 then
                cejeMessage = "I BEAT NEW TOP 1"
            else cejeMessage = "Getting far..."
            end

            if choice == 1 then
                return{
                    mult = card.ability.extra.mult * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 2 then
                return{
                    chips = card.ability.extra.chips * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 3 then
                return{
                    dollars = card.ability.extra.dollars * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 4 then
                return{
                    x_mult = card.ability.extra.x_mult * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 5 then
                return{
                    x_chips = card.ability.extra.x_chips * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.dollars, card.ability.extra.x_mult, card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "typier",
    path = "j_typier.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "typier",                                  
    config = { extra = { x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'typier',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card.ability.name == 'Lucky Card' and (not context.other_card.lucky_trigger) and (not context.blueprint) then
            card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
            return {
                message = "Died Far",
                colour = G.C.RED
            }
        end
        if context.individual and context.other_card.lucky_trigger and (not context.blueprint) then
            card.ability.extra.x_mult = 1
            return {
                message = "Patience...",
                colour = G.C.RED
            }
		end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult} }
    end
}

SMODS.Atlas({
    key = "jaynt",
    path = "j_jaynt.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "jaynt",                                  
    config = { extra = { h_size = -3 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=false,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'jaynt',                                

    calculate = function(self,card,context)
        if card.added_to_deck and (not context.blueprint) then
            card.added_to_deck = false
            G.E_MANAGER:add_event(Event({func = function()
            change_shop_size(5)
            return true end }))
            G.hand:change_size(card.ability.extra.h_size)
        end
        if context.selling_self and (not context.blueprint) then
            G.E_MANAGER:add_event(Event({func = function()
            change_shop_size(-5)
            return true end }))
            G.hand:change_size(-card.ability.extra.h_size)
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.h_size} }
    end
}

SMODS.Atlas({
    key = "dangadash",
    path = "j_dangadash.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "dangadash",                                  
    config = { extra = { chips = 0 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'dangadash',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and (not context.blueprint) then
            if context.other_card:get_id() == 11 then
                card.ability.extra.chips = card.ability.extra.chips + 10
                return {
                    extra = { focus = card, message = "Hey daddy", colour = G.C.CHIPS},
                    card = card
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end
}

SMODS.Sound({key = "bell", path = "Bell.ogg"})
SMODS.Atlas({
    key = "raptor",
    path = "j_electroraptor.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "raptor",                                  
    config = { extra = { x_mult = 1 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'raptor',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
        if context.after and (not context.blueprint) then
            for k, v in ipairs(context.scoring_hand) do
                if not v.shattered and v.ability.name == "Glass Card" then 
                    card.ability.extra.x_mult = card.ability.extra.x_mult + 0.1
                    return {
                        extra = { focus = card, message = "Amen", colour = G.C.MULT, sound = 'lrr_bell'}
                    }
                 end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "zeralth",
    path = "j_zeralth.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "zeralth",                                  
    config = { extra = { x_mult = 1.9 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'zeralth',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            local hasAce, hasNine = false
            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 9 then
                    hasNine = true
                end
                if context.full_hand[i]:get_id() == 14 then
                    hasAce = true
                end
            end

            if hasNine and hasAce then
                return{
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "lucky",
    path = "j_luckyns.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "lucky",                                  
    config = { },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'lucky',                                

    calculate = function(self,card,context)
        if context.repetition then
            if context.cardarea == G.play then
                if context.other_card.ability.name == "Lucky Card" and context.other_card:get_id() == 7 then
                    return{
                        message = 'Lucky Seven!',
                        repetitions = 3,
                        card = card
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Sound({key = "explosion", path = "Explosion.ogg"})
SMODS.Atlas({
    key = "darkgamma",
    path = "j_darkgamma.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "darkgamma",                                  
    config = { extra = { chips = 200, chance = 6 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'darkgamma',                                

    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and (not context.blueprint) then
            if pseudorandom('darkgamma') < G.GAME.probabilities.normal/card.ability.extra.chance then
                G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('lrr_explosion')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(card)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                end
                            }))
                    return {
                        message = 'Kaboom',
                        colour = G.C.CHIPS
                    }
                else
                    return {
                        message = 'Safe',
                        colour = G.C.CHIPS
                    }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, (G.GAME.probabilities.normal or 1) } }
    end
}

SMODS.Atlas({
    key = "donut",
    path = "j_wwdonut.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "donut",                                  
    config = { extra = {dollars = 3} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'donut',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 then
            if context.other_card.seal == "lrr_plus_seal" then
                return {
                    dollars = card.ability.extra.dollars,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end
}

SMODS.Atlas({
    key = "cedric",
    path = "j_cedric.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cedric",                                  
    config = { extra = { x_chips = 2} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cedric',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            local sixes = 0
            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 6 then
                    sixes = sixes + 1
                end
            end

            if sixes == 2 then
                return{
                    x_chips = card.ability.extra.x_chips,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "wacky",
    path = "j_wacky.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "wacky",                                  
    config = { extra = { chance = 15} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=false,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'wacky',                                

    calculate = function(self,card,context)
        if context.reroll_shop and (not context.blueprint) then
            local activated = false;
            for i = 1, #G.shop_jokers.cards do
                if pseudorandom('wacky') < G.GAME.probabilities.normal/card.ability.extra.chance and G.shop_jokers.cards[i].ability.set == 'Joker' then
                    G.shop_jokers.cards[i]:set_edition({negative = true}, true)
                    activated = true
                end
            end
            if activated then return{
                    message = 'Focus Pocus',
                    card = card,
                    colour = G.C.BLACK
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {(G.GAME.probabilities.normal or 1)}}
    end
}

SMODS.Atlas({
    key = "lobster",
    path = "j_lobster.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "lobster",                                  
    config = { extra = { x_chips = 1.5 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'lobster',                                

    calculate = function(self,card,context)
        if context.discard and (not context.blueprint) then
            if card.ability.extra.x_chips - 0.01 <= 1 then 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.CHIPS
                    }
            else
                    card.ability.extra.x_chips = card.ability.extra.x_chips - 0.01
                    return {
                        delay = 0.2,
                        message = "Nom",
                        colour = G.C.CHIPS
                    }
            end       
        end

        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "meow",
    path = "j_meow.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "meow",                                  
    config = { extra = { repetitions = 1} },                
    pos = { x = 0, y = 0 },        
    pools = {["LRRmodAddition"] = true},                 
    rarity = 3,                                        
    cost = 10,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'meow',                                

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and context.scoring_name == 'Pair' then
            local cards = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.seal == "lrr_plus_seal" then 
                    cards = cards + 1
                end
            end
            if cards == 2 then
                return{
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card,
                }
            end
        end
        if context.after and (not context.blueprint) then
            local cards = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.seal == "lrr_plus_seal" then 
                    cards = cards + 1
                end
            end
            if cards == 2 then
                card.ability.extra.repetitions = card.ability.extra.repetitions + 1
                return{
                    message = "+1 Repetition",
                    colour = G.C.GREEN,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.repetitions} }
    end
}

SMODS.Atlas({
    key = "emil",
    path = "j_emil.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "emil",                                  
    config = { extra = { mult = 9.5, chips = 95} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'emil',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            return{
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.chips } }
    end
}

SMODS.Atlas({
    key = "cooper",
    path = "j_cooper.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cooper",                                  
    config = { extra = { x_mult = 1.5} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cooper',                                

    calculate = function(self,card,context)
        if not context.end_of_round then
            if context.cardarea == G.hand and context.individual and context.other_card.ability.name == 'm_lrr_card' then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult} }
    end
}


function showCrash()
    play_sound('lrr_bsod', 1, 100)
    sleep(2)
    local file_data = assert(NFS.newFileData("full_path"),("Samamba got far on Hatred, too bad they hit em with the 'O dispositivo encontrou um problem e precisa ser reiniciado. Estarmos coletando algumas informacoes sobre o erro e, em seguida, reiniciaremos para voce.'"))
end

function sleep(seconds)
    local start_time = os.time()
    repeat until os.time() > start_time + seconds
end