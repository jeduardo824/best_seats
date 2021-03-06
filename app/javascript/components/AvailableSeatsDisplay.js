import React from "react";
import styled from "styled-components";
import swal from "sweetalert";
import _ from "lodash";
import { Api } from "../services";

const MainDiv = styled.div`
  text-align: center;
  color: #F3F7F0;
  justify-content: center;
  min-height: 50px;
`

const StyledTitle = styled.h3`
  color: #F3F7F0;
`

const StyledButton = styled.button`
  margin: 10px 0;
`

const AvailableSeatsDisplay = ({ availableSeats, setVenueId, venueParams }) => {
  const humanizedSeats = availableSeats.map((seat) => {
    return `${seat.row}${seat.column} `;
  });

  const createVenue = () => {
    Api.Venue.create(venueParams, availableSeats)
             .then((response) => {
               setVenueId(response.data.venue_id);
               swal("Success!", "Venue created successfully!", "success");
             })
             .catch((response) => {
               var message = error.response.data.errors;
               swal("Error!", message, "error");
             });
  }

  return(
    <MainDiv>
      <div className="humanized-seats">
        { humanizedSeats.sort() }
      </div>
      {
        _.isEmpty(availableSeats) ?
        <StyledTitle>Select the available seats</StyledTitle> :
        <StyledButton onClick={createVenue}>
          Create Venue
        </StyledButton>
      }
    </MainDiv>
  )
}

StyledTitle.displayName = "StyledTitle";
StyledButton.displayName = "StyledButton";
export default AvailableSeatsDisplay;
