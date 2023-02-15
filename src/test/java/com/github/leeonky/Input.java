package com.github.leeonky;

public class Input {
    private final int style;

    public Input(int style) {
        this.style = style;
    }

    public String result() {
        return style + "(0):\n" +
                "| " + style + " |";
    }
}
