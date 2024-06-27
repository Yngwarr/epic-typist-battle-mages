package org.example.entity.spell;

import org.example.entity.spell.attack.ExplosionSpell;
import org.example.entity.spell.attack.FireballSpell;
import org.example.entity.spell.attack.MagicMissleSpell;
import org.example.entity.spell.buff.ConcentrationSpell;
import org.example.entity.spell.debuff.ConfusionSpell;
import org.example.entity.spell.debuff.DyslexiaSpell;
import org.example.entity.spell.debuff.StickinessSpell;

public class SpellFabric {

    public static Spell getSpell(SpellName spellName) {
        return switch (spellName) {
            case SpellName.MAGIC_MISSILE -> new MagicMissleSpell();
            case SpellName.STICKINESS -> new StickinessSpell();
            case SpellName.CONFUSION -> new ConfusionSpell();

            case SpellName.FIREBALL -> new FireballSpell();
            case SpellName.EXPLOSION -> new ExplosionSpell();
            case SpellName.DYSLEXIA -> new DyslexiaSpell();
            case SpellName.CONCENTRATION -> new ConcentrationSpell();
        };
    }
}
