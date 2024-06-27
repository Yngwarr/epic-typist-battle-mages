package org.example.entity.spell;

public class SpellFabric {

    public static Spell getSpell(SpellName spellName) {
        return switch (spellName) {
            case SpellName.FIREBALL -> new BasicDamageSpell();
            case SpellName.DEBUFF_SLOW -> new DebuffSlowSpell();
        };
    }
}
