import React from "react";
import { shallow } from "enzyme";
import App  from "components/App";
import Venue from "components/Venue";

describe("Components", () => {
  describe("<App />", () => {
    const setup = () => {
      const wrapper = shallow(<App />);

      return {
        wrapper
      };
    };

    const { wrapper } = setup();

    describe("children", () => {
      describe("<Venue />", () => {
        it("renders correctly", () => {
          const venue = wrapper.find(Venue);

          expect(venue).toHaveLength(1);
        });
      });
    });

    describe("content", () => {
      describe("<StyledTitle />", () => {
        const title = wrapper.find("StyledTitle");

        it("renders correctly", () => {
          expect(title).toHaveLength(1);
        });

        it("has the correct content", () => {
          const text = "Best Seats App";

          expect(title.text()).toEqual(text);
        });
      });
    });
  });
});
