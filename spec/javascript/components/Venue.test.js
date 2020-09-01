import React from "react";
import { shallow } from "enzyme";
import Venue from "components/Venue";
import VenueForm from "components/VenueForm";
import SeatsSelector from "components/SeatsSelector";

describe("Components", () => {
  describe("<Venue />", () => {
    const setup = () => {
      const wrapper = shallow(<Venue />);

      return {
        wrapper
      };
    };

    describe("children", () => {
      describe("<VenueForm />", () => {
        describe("when params is empty", () => {
          const { wrapper } = setup();
          const venueForm = wrapper.find(VenueForm);

          it("renders correctly", () => {
            expect(venueForm).toHaveLength(1);
          });
        })
      });

      describe("<SeatsSelector />", () => {
        describe("when params is empty", () => {
          const { wrapper } = setup();
          const seatsSelector = wrapper.find(SeatsSelector);

          it("renders correctly", () => {
            expect(seatsSelector).toHaveLength(0);
          });
        })
      });
    });
  });
});
