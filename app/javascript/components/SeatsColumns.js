import React from "react";
import styled from "styled-components";
import SeatsRow from "./SeatsRow";

const Columns = styled.div`
  display: flex;
  justify-content: center;
  margin-top: 45px;
  margin-right: 22px;
`

const SeatsColumns = ({
  availableSeats,
  bestSeats,
  params,
  setAvailableSeats,
  venueId
}) => {
  const renderColumns = () => {
    var columns = [];

    for(let column = 1; column <= params.columns; column++) {
      columns.push(
        <SeatsRow
          key={column}
          setAvailableSeats={setAvailableSeats}
          availableSeats={availableSeats}
          bestSeats={bestSeats}
          venueId={venueId}
          column={column}
          rows={params.rows}
        />
      )
    }

    return columns;
  }

  return(
    <Columns>
      { renderColumns() }
    </Columns>
  )
}

export default SeatsColumns;
