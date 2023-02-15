package com.github.leeonky;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    public static class LinerCutting {
        private final List<Input> inputs = new ArrayList<>();

        public String resultContent() {
            return inputs.stream().map(Input::result).collect(Collectors.joining("\n\n"));
        }

        public void addAvailable(int length, int count) {
            while (count-- > 0) {
                inputs.add(new Input(length));
            }
        }
    }
}
