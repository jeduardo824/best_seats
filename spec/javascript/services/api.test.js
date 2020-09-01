import React from "react";
import mockAxios from "jest-mock-axios";
import { Api } from "services";

afterEach(() => {
  mockAxios.reset();
});

describe("Api", () => {
  Api.request = mockAxios;

  describe("Venue", () => {
    describe("create", () => {
      const venueParams = {
        title: "My Test Venue",
        rows: 5,
        columns: 5,
      };
      const availableSeats = [
        {
          row: "a",
          column: 1
        }
      ];
      const params = {
        venue: {
          ...venueParams,
          available_seats: availableSeats
        }
      };

      it("makes the request successfully", async() => {
        Api.Venue.create(venueParams, availableSeats);

        expect(mockAxios.post).toHaveBeenCalledWith("/api/v1/venues", params);
      });

      it("makes the request only one time", async() => {
        Api.Venue.create(venueParams, availableSeats);

        expect(mockAxios.post).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe("BestSeats", () => {
    describe("find", () => {
      const venueId = 1;
      const params = {
        seats_quantity: 2,
        group_seats: false
      };
      const urlParams = `seats_quantity=${params.seats_quantity}&group_seats=${params.group_seats}`;
      const url = `api/v1/venues/${venueId}/best_seats?${urlParams}`;

      it("makes the request successfully", async() => {
        Api.BestSeats.find(venueId, params);

        expect(mockAxios.get).toHaveBeenCalledWith(url);
      });

      it("makes the request only one time", async() => {
        Api.BestSeats.find(venueId, params);

        expect(mockAxios.get).toHaveBeenCalledTimes(1);
      });
    });
  });
});
