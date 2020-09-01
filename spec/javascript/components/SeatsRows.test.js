import React from "react";
import { shallow } from "enzyme";
import SeatsRow from "components/SeatsRow";
import Seat from "components/Seat";

describe("Components", () => {
  describe("<SeatsColumns />", () => {
    const setup = (availableSeats, bestSeats, column, rows, venueId) => {
      const setAvailableSeats = jest.fn();
      const wrapper = shallow(<SeatsRow
                               availableSeats={availableSeats}
                               bestSeats={bestSeats}
                               column={column}
                               rows={rows}
                               setAvailableSeats={setAvailableSeats}
                               venueId={venueId} />);

      return {
        wrapper
      };
    };

    describe("children", () => {
      describe("<Seat />", () => {
        it("renders correctly", () => {
          const row = 2;
          const { wrapper } = setup([], [], null, row, null);
          const seats = wrapper.find(Seat);

          expect(seats).toHaveLength(2);
        });
      });
    });
  });
});
