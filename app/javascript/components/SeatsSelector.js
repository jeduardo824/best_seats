import React, { useState } from "react";
import styled from "styled-components";
import AvailableSeatsDisplay from "./AvailableSeatsDisplay";
import BestSeatsForm from "./BestSeatsForm";
import SeatsColumns from "./SeatsColumns";
import SeatsRow from "./SeatsRow";

const MainDiv = styled.div`
  width: 100%;
  height: 100%;
  display: grid;
  justify-content: center;
`

const SeatsSelector = ({ params }) => {
  const [availableSeats, setAvailableSeats] = useState([]);
  const [bestSeats, setBestSeats] = useState([]);
  const [venueId, setVenueId] = useState(null);

  return(
    <MainDiv>
      {
        venueId ?
        <BestSeatsForm
          setBestSeats={setBestSeats}
          venueId={venueId}
        /> :
        <AvailableSeatsDisplay
          availableSeats={availableSeats}
          setVenueId={setVenueId}
          venueParams={params}
        />
      }
      <SeatsColumns
        availableSeats={availableSeats}
        bestSeats={bestSeats}
        params={params}
        setAvailableSeats={setAvailableSeats}
        venueId={venueId}
      />
    </MainDiv>
  )
}

export default SeatsSelector;
