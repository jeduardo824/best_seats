import React from "react";
import { shallow } from "enzyme";
import mockAxios from "jest-mock-axios";
import AvailableSeatsDisplay  from "components/AvailableSeatsDisplay";
import { Api } from "services";

afterEach(() => {
  mockAxios.reset();
});

describe("Components", () => {
  describe("<AvailableSeatsDisplay />", () => {
    const setup = (availableSeats, venueParams) => {
      const setVenueId = jest.fn();
      const wrapper = shallow(<AvailableSeatsDisplay
                               availableSeats={availableSeats}
                               setVenueId={setVenueId}
                               venueParams={venueParams} />);

      return {
        wrapper
      };
    };

    describe("content", () => {
      describe("Availabe Seats List", () => {
        describe("when availableSeats is not empty", () => {
          const availableSeats = [
            { row: "A", column: 1 },
            { row: "B", column: 5 },
          ];
          const { wrapper } = setup(availableSeats, {});
          const seatsList = wrapper.find(".humanized-seats");

          it("renders the available seats List", () => {
            expect(seatsList.text()).toEqual("A1 B5 ");
          });
        });
      });

      describe("<StyledTitle />", () => {
        describe("when availableSeats is empty", () => {
          const availableSeats = [];
          const { wrapper } = setup(availableSeats, {});
          const title = wrapper.find("StyledTitle");

          it("renders correctly", () => {
            expect(title).toHaveLength(1);
          });

          it("has the correct content", () => {
            const text = "Select the available seats";

            expect(title.text()).toEqual(text);
          });
        });

        describe("when availableSeats is not empty", () => {
          const availableSeats = [{ row: 1, column: 1 }];
          const { wrapper } = setup(availableSeats, {});
          const title = wrapper.find("StyledTitle");

          it("does not render StyledTitle", () => {
            expect(title).toHaveLength(0);
          });
        });
      });

      describe("<StyledButton />", () => {
        describe("when availableSeats is empty", () => {
          const availableSeats = [];
          const { wrapper } = setup(availableSeats, {});
          const button = wrapper.find("StyledButton");

          it("renders correctly", () => {
            expect(button).toHaveLength(0);
          });
        });

        describe("when availableSeats is not empty", () => {
          const availableSeats = [{ row: 1, column: 1 }];
          const venueParams = { title: "MyTitle" };
          const { wrapper } = setup(availableSeats, venueParams);
          const button = wrapper.find("StyledButton");

          it("does not render StyledTitle", () => {
            expect(button).toHaveLength(1);
          });

          it("has the correct content", () => {
            const text = "Create Venue";

            expect(button.text()).toEqual(text);
          });

          it("triggers the correct event clicking on the button", async() => {
            Api.request = mockAxios;

            const params = {
              venue: {
                ...venueParams,
                available_seats: availableSeats
              }
            };

            button.simulate("click");

            expect(mockAxios.post).toHaveBeenCalledWith("/api/v1/venues", params);
            expect(mockAxios.post).toHaveBeenCalledTimes(1);
          });
        });
      });
    });
  });
});
