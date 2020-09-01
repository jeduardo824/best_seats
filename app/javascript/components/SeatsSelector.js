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

const StageDiv = styled(MainDiv)`
  background-color: #999999;
`

const ReloadButton = styled.button`
  margin: 10px 165px;
  position: relative;
  right: 8%;
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
      <StageDiv>STAGE</StageDiv>
      <SeatsColumns
        availableSeats={availableSeats}
        bestSeats={bestSeats}
        params={params}
        setAvailableSeats={setAvailableSeats}
        venueId={venueId}
      />
      <ReloadButton onClick={() => window.location.reload(false)}>
        Create new Venue
      </ReloadButton>
    </MainDiv>
  )
}

export default SeatsSelector;
