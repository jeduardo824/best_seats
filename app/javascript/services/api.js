import axios from "axios"

const defaultToken = { content: "no-csrf-token" };
const token = document.querySelector("[name=\"csrf-token\"]") || defaultToken;

export const request = axios.create({
  headers: {
    common: {
      "X-CSRF-Token": token.content
    }
  }
});

const Api = {
  request: request
}

Api.Venue = {
  create: (venueParams, availableSeats) => {
    const params = {
      venue: {
        ...venueParams,
        available_seats: availableSeats
      }
    }

    return Api.request.post("/api/v1/venues", params);
  }
}

Api.BestSeats = {
  find: (venueId, params) => {
    const seatParams = `seats_quantity=${params.seats_quantity}&group_seats=${params.group_seats}`;
    return Api.request.get(`api/v1/venues/${venueId}/best_seats?${seatParams}`);
  }
}

export { Api };

export default Api;
