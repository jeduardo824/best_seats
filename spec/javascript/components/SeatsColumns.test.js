import React from "react";
import { shallow } from "enzyme";
import SeatsColumns from "components/SeatsColumns";
import SeatsRow from "components/SeatsRow";

describe("Components", () => {
  describe("<SeatsColumns />", () => {
    const setup = (availableSeats, bestSeats, params, venueId) => {
      const setAvailableSeats = jest.fn();
      const wrapper = shallow(<SeatsColumns
                               availableSeats={availableSeats}
                               bestSeats={bestSeats}
                               params={params}
                               setAvailableSeats={setAvailableSeats}
                               venueId={venueId} />);

      return {
        wrapper
      };
    };

    describe("children", () => {
      describe("<SeatsRow />", () => {
        it("renders correctly", () => {
          const params = { rows: 2, columns: 2 };
          const { wrapper } = setup([], [], params, null);
          const seatsRow = wrapper.find(SeatsRow);

          expect(seatsRow).toHaveLength(2);
        });
      });
    });
  });
});
