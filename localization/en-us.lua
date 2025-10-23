return {
  descriptions = {
    curt_rev_tarot = {
      c_curt_rev_fool = {
        name = "The Reversed Fool",
        text = {
          "When another consumable is used,",
          "generate two random {C:tarot}Reversed Tarot{}",
          "cards or {C:spectral}Spectral{} cards.",
          "{C:inactive}(Black Hole and Soul excluded)",
        },
      },
      c_curt_rev_magician = {
        name = "The Reversed Magician",
        text = {
          "Guarantees the next",
          "{C:attention}listed{} {C:green,E:1,S:1.1}probability",
          "{C:inactive}(ex: {C:green}1 in 10{C:inactive} -> {C:green}10 in 10{C:inactive})",
        },
      },
      c_curt_rev_high_priestess = {
        name = "The Reversed High Priestess",
        text = {
          "When a {C:planet}Planet{} card is purchased,",
          "create two {C:dark_edition}Negative{} copies of it.",
        },
      },
      c_curt_rev_empress = {
        name = "The Reversed Empress",
        text = {
          "When a {C:attention}consumable{} is sold,",
          "create three {C:dark_edition}Negative{} copies of it.",
          "{C:inactive}(The Reversed Empress Excluded){}",
        },
      },
      c_curt_rev_emperor = {
        name = "The Reversed Emperor",
        text = {
          "When a card or hand {C:attention}debuffed{} by",
          "a {C:attention}Boss Blind{} is played, the {C:attention}Boss",
          "{C:attention}Blind{} is disabled.",
        },
      },
      c_curt_rev_heirophant = {
        name = "The Reversed Heirophant",
        text = {
          "When a 5 card {C:attention}High Card{}",
          "hand is played, adds",
          "{C:chips}+#1#{} to each card",
          "held in hand",
        },
      },
      c_curt_rev_lovers = {
        name = "The Reversed Lovers",
        text = {
          "Creates a random tag if",
          "poker hand contains a",
          "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
          "{C:hearts}Heart{} card, and {C:spades}Spade{} card",
        },
      },
      c_curt_rev_chariot = {
        name = "The Reversed Chariot",
        text = {
          "When purchasing a voucher,",
          "a second, random voucher",
          "is immediately purchased",
        },
      },
      c_curt_rev_justice = {
        name = "The Reversed Justice",
        text = {
          "When a poker hand is played,",
          "scored cards are {C:attention}returned to",
          "{C:attention}the hand{} after drawing",
        },
      },
      c_curt_rev_hermit = {
        name = "The Reversed Hermit",
        text = {
          "When player has 0 jokers,",
          "grants {C:money}$#1#{}",
        },
      },
      c_curt_rev_wheel_of_fortune = {
        name = "The Reversed Wheel of Fortune",
        text = {
          "When a poker hand is played,",
          "add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
          "or {C:dark_edition}Polychrome{} effect to",
          "each scored card.",
          "Additionally, {C:green,E:1,S:1.1}#1# in #2#{} chance to",
          "{C:attention}destroy{} each scored card.",
        },
      },
      c_curt_rev_strength = {
        name = "The Reversed Strength",
        text = {
          "When cards are discarded,",
          "discarded cards are {C:attention}destroyed{}"
        },
      },
      c_curt_rev_hanged_man = {
        name = "The Reversed Hanged Man",
        text = {
          "When cards are drawn to hand,",
          "remove all {C:enhanced}Enhancements{}, {C:attention}Seals{},",
          "and {C:dark_edition}Editions{} from each card",
          "Grants {C:money}$#1#{} for each removed",
        },
      },
      c_curt_rev_death = {
        name = "The Reversed Death",
        text = {
          "Upon beating a blind,",
          "{C:attention}-#1#{} Ante, {C:attention}-#2#{} Hand Size",
        },
      },
      c_curt_rev_temperance = {
        name = "The Reversed Temperance",
        text = {
          "When a card is added to the deck,",
          "also add four copies of it with",
          "{C:attention,E:1,S:1.1}consecutively increasing ranks.",
        },
      },
      c_curt_rev_devil = {
        name = "The Reversed Devil",
        text = {
          "When player has both {C:money}$0{},",
          "and {C:attention}0 jokers{}, generates",
          "two {C:dark_edition}Negative{} {C:red}Rare Jokers",
        },
      },
      c_curt_rev_tower = {
        name = "The Reversed Tower",
        text = {
          "Prevents Death from having 0 Hands",
          "by granting {C:blue}+#1#{} Hand and",
          "{C:red}+#2#{} Discards",
        },
      },
      c_curt_rev_star = {
        name = "The Reversed Star",
        text = {
          "When {C:attention}#1#{} is destroyed,",
          "create a new Joker with the",
          "same rarity and edition",
          "{C:inactive}(Must have room)",
        },
      },
      c_curt_rev_moon = {
        name = "The Reversed Moon",
        text = {
          "When a playing card is destroyed,",
          "remove {C:enhancement}Enhancement{} from each {C:attention}Stone Card",
          "in hand, and convert to the suit and",
          "rank of the {C:attention}leftmost{} card held in hand",
        },
      },
      c_curt_rev_sun = {
        name = "The Reversed Sun",
        text = {
          "When both effects of a {C:attention}Lucky",
          "card trigger, permanently",
          "doubles the {C:green,E:1,S:1.1}probability",
          "of triggering both effects.",
        },
      },
      c_curt_rev_judgement = {
        name = "The Reversed Judgement",
        text = {
          "When skipping a {C:attention}Booster Pack{} in the Shop,",
          "destroy and restock {C:attention}Booster Packs{} in the Shop",
        },
      },
      c_curt_rev_world = {
        name = "The Reversed World",
        text = {
          "When any Card Area has more cards in it",
          "than its limit, {C:attention}destroy{} all cards",
          "in the Card Area. Card Area size {C:red}#1##2#{}",
        },
      },
    },
    Other = {
      undiscovered_curt_rev_tarot = {
        name = "Not Discovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does",
        },
      },
    },
  },
  misc = {
    dictionary = {
      b_curt_rev_tarot_cards = "Reversed Tarot Cards",
      k_curt_rev_tarot = "Reversed Tarot",
      b_take = "TAKE",
    },
    labels = {
      curt_rev_tarot = "Reversed Tarot",
    },
  },
}
