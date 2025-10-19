curt_Consumable {
  key = "rev_fool",
  pos = { x = 0, y = 0 },

  calculate = function(self, card, context)
    if context.using_consumeable then
      print("hi")
    end
  end
}
