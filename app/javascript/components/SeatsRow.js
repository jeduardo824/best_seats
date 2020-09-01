import React from "react";
import styled from "styled-components";
import Seat from "./Seat";

const Row = styled.div`
  transform: skew(-10deg);
  margin: 0 4px;
`

const SeatsRow = ({
  availableSeats,
  bestSeats,
  column,
  rows,
  setAvailableSeats,
  venueId
}) => {
  const renderSeats = () => {
    var seats = [];

    for(let row=1; row <= rows; row++) {
      seats.push(
        <Seat
          key={row}
          availableSeats={availableSeats}
          bestSeats={bestSeats}
          column={column}
          row={row}
          setAvailableSeats={setAvailableSeats}
          venueId={venueId}
        />
      )
    }

    return seats;
  }

  return(
    <Row>
      { renderSeats() }
    </Row>
  )
}

export default SeatsRow;
