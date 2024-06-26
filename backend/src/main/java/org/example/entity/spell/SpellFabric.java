package org.example.entity.spell;

public class SpellFabric {

    public static DamageSpell getSpell(SpellName spellName) {
        switch(spellName) {
            case SpellName.FIREBALL:
                return new BasicDamageSpell();
        }
        return null;
    }
}
