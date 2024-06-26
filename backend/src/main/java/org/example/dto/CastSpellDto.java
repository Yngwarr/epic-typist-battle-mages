package org.example.dto;

import lombok.Getter;
import lombok.ToString;
import org.example.entity.spell.SpellName;

@ToString
@Getter
public class CastSpellDto {
    public String spellCastId;
    public String playerFromId;
    public SpellName spellName;
    public String playerToId;
}
