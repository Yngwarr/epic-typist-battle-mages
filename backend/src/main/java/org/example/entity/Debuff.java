package org.example.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.Duration;
import java.time.ZonedDateTime;

@Getter
@Setter
@AllArgsConstructor
public class Debuff {
    private String name;

    @JsonIgnore
    private ZonedDateTime initTimestamp;

    @JsonIgnore
    private ZonedDateTime endTimestamp;

    @JsonProperty("timeLeft")
    public long timeLeft() {
        ZonedDateTime now = ZonedDateTime.now();
        return Duration.between(now, endTimestamp).getSeconds();
    }
}
