package com.github.leeonky;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Input {
    final int style;
    final List<Integer> segments = new ArrayList<>();

    public Input(int style) {
        this.style = style;
    }

    public String result() {
        String result = String.format("%d(%d) %d:\n| %d |", style, segments.size(), left(), style);
        if (segments.size() > 0) {
            result += "\n" + segments.stream().map(Object::toString).collect(Collectors.joining(" | ", "| ", " |"));
        }
        return result;
    }

    public void split(int length) {
        segments.add(length);
    }

    boolean splitMore(int length) {
        return left() >= length;
    }

    public int left() {
        return style - segments.stream().mapToInt(Integer::intValue).sum();
    }

    public Input copy() {
        Input input = new Input(style);
        input.segments.addAll(segments);
        return input;
    }

    @Override
    public String toString() {
        return "Input{" +
                "style=" + style +
                ", segments=" + segments +
                '}';
    }
}
