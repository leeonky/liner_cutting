package com.github.leeonky;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import static com.github.leeonky.dal.Assertions.expect;
import static java.lang.Integer.parseInt;

public class Steps {
    private LinerCutting linerCutting;

    @Before
    public void init() {
        linerCutting = new LinerCutting();
    }

    @Given("the following lines:")
    public void the_following_lines(DataTable dataTable) {
        dataTable.asLists().forEach(liner -> linerCutting.addAvailable(parseInt(liner.get(0)), parseInt(liner.get(1))));
    }

    @Then("got following result:")
    public void got_following_result(String verification) {
        expect(linerCutting).should(verification);
    }

    @When("need segments:")
    public void need_segments(DataTable dataTable) {
        dataTable.asLists().forEach(liner -> linerCutting.needSegment(parseInt(liner.get(0)), parseInt(liner.get(1))));
    }

    private List<Integer> inputArray;

    @Given("the following data:")
    public void the_following_data(DataTable dataTable) {
        inputArray = dataTable.asList().stream().map(Integer::parseInt).collect(Collectors.toList());
    }

    @Then("the full arrangement should:")
    public void the_full_arrangement_should(String verification) {
        expect(fullArrangement(inputArray)).should(verification);
    }

    public static List<List<Integer>> fullArrangement(List<Integer> list) {
        if (list.size() == 0)
            return new ArrayList<List<Integer>>() {{
                add(new ArrayList<>());
            }};
        return IntStream.range(0, list.size()).mapToObj(i -> arrangeExceptAt(list, i))
                .flatMap(Function.identity()).collect(Collectors.toList());
    }

    private static Stream<List<Integer>> arrangeExceptAt(List<Integer> list, int index) {
        LinkedList<Integer> left = new LinkedList<>(list);
        int except = left.remove(index);
        return fullArrangement(left).stream().map(l -> new ArrayList<Integer>() {{
            add(except);
            addAll(l);
        }});
    }

    public static class LinerCutting {
        private final List<Input> inputs = new ArrayList<>();
        private final List<Integer> availables = new ArrayList<>();
        private final List<Integer> segments = new ArrayList<>();

        public String resultContent() {
            return split().stream().map(Input::result).collect(Collectors.joining("\n\n"));
        }

        private List<Input> split() {
            List<List<Input>> result =
                    fullArrangement(availables).stream().flatMap(availables1 -> fullArrangement(segments).stream().map(segments1 ->
                                    splitInner(segments1, availables1))).filter(Objects::nonNull)
                            .sorted((l1, l2) -> wast(l2) - wast(l1))
                            .collect(Collectors.toList());
            if (result.size() == 0)
                throw new IllegalStateException("Given input is not enough");
            return result.get(0);
        }

        private int wast(List<Input> inputs) {
            return inputs.stream().mapToInt(Input::left).max().orElse(0);
        }

        private List<Input> splitInner(List<Integer> segments, List<Integer> availables1) {
            try {
                List<Input> inputs = availables1.stream().map(Input::new).collect(Collectors.toList());
                segments.forEach(length -> inputs.stream().filter(input -> input.splitMore(length)).findFirst()
                        .orElseThrow(() -> new IllegalStateException("Given input is not enough"))
                        .split(length));
                return inputs;
            } catch (Exception e) {
                return null;
            }
        }

        public void addAvailable(int length, int count) {
            while (count-- > 0) {
                availables.add(length);
            }
        }

        public void needSegment(int length, int count) {
            segments.add(length);
        }
    }
}
