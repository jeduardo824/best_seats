import React from "react";
import { shallow } from "enzyme";
import BestSeatsForm  from "components/BestSeatsForm";

describe("Components", () => {
  describe("<BestSeatsForm />", () => {
    const setup = (venueId) => {
      const setBestSeats = jest.fn();
      const wrapper = shallow(<BestSeatsForm
                               setBestSeats={setBestSeats}
                               venueId={venueId} />);

      return {
        wrapper
      };
    };

    describe("content", () => {
      describe("<StyledLabel />", () => {
        const { wrapper } = setup(1);
        const label = wrapper.find("StyledLabel");

        it("renders correctly", () => {
          expect(label).toHaveLength(1);
        });

        it("has the correct content", () => {
          const text = "Number of best seats desired:";

          expect(label.text()).toEqual(text);
        });
      });

      describe("<StyledButton />", () => {
        const { wrapper } = setup(1);
        const button = wrapper.find("StyledButton");

        it("renders correctly", () => {
          expect(button).toHaveLength(1);
        });

        it("has the correct content", () => {
          const text = "Find!";

          expect(button.props().value).toEqual(text);
        });
      });
    });
  });
});
