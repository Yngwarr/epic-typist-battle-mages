package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Buff {
    private String name;
    // here timestamp is string because
    // jackson cannot convert ZoneDateTime
    // and we cannot use old java datetime classes
    // in java 22
    // and we cannot add jackson module into the socket-io library :)
    private String initTimestamp;
    private String endTimestamp;
}
