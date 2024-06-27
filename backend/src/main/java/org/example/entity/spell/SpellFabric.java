package org.example.entity.spell;

public class SpellFabric {

    public static Spell getSpell(SpellName spellName) {
        switch(spellName) {
            case SpellName.FIREBALL:
                return new BasicDamageSpell();
            case SpellName.DEBUFF_SLOW:
                return new DebuffSlowSpell();
        }
        return null;
    }
}
