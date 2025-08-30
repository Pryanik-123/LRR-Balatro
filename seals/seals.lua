SMODS.Atlas {
    key = "plus_seal",
    path = "LRRplusseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "plus_seal",
    key = "plus_seal",
    badge_colour = HEX("00ccff"),
	config = { mult = 7.5, chips = 75  },
    loc_txt = {
        label = 'LRR+ Seal',
        name = 'LRR+ Seal',
        text = {
            '{C:red}+#1#{} Mult and {C:chips}+#2#{} Chips',
            'when this card is',
            'played and scored'
        }
    },


    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips } }
    end,
    atlas = "plus_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = self.config.mult,
                chips = self.config.chips
            }
        end
    end,
}

SMODS.Atlas {
    key = "ulrr_seal",
    path = "ulrrseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "ulrr_seal",
    key = "ulrr_seal",
    badge_colour = HEX("ff0000"),
	config = { dollars = 1, x_chips = 1.1, x_mult = 1.1  },
    loc_txt = {
        label = 'ULRR Seal',
        name = 'ULRR Seal',
        text = {
            '{C:money}$#1#{} Moners',
            '{X:chips,C:white}X#2#{} Chips',
            '{X:mult,C:white}X#3#{} Mult',
            'when this card is',
            'played and scored'
        }
    },


    loc_vars = function(self, info_queue)
        return { vars = {self.config.dollars, self.config.x_chips, self.config.x_mult } }
    end,
    atlas = "ulrr_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = self.config.dollars,
                chips = self.config.chips,
                mult = self.config.mult,
                x_chips = self.config.x_chips,
                x_mult = self.config.x_mult
            }
        end
    end,
}