import React from "react";
import styled from "styled-components";
import swal from "sweetalert";
import { useForm } from "react-hook-form";
import { Api } from "../services";

const MainDiv = styled.div`
  text-align: center;
  color: #F3F7F0
`

const StyledLabel = styled.label`
  color: #F3F7F0;
  margin: 5px 0;
`

const StyledText = styled.p`
  color: #C94949;
  margin: 4px 0;
`

const StyledButton = styled.input`
  margin: 10px 30%;
`

const ReloadButton = styled.button`
  margin: 10px;
`

const BestSeatsForm = ({ setBestSeats, venueId }) => {
  const { register, handleSubmit, errors } = useForm();

  const getBestSeats = (data) => {
    Api.BestSeats.find(venueId, data)
                 .then((response) => {
                    setBestSeats(response.data.best_seats);
                 })
                 .catch((error) => {
                    var message = error.response.data.error;
                    swal("Error!", message, "error");
                 });
  }

  return(
    <MainDiv>
      <form onSubmit={handleSubmit(getBestSeats)}>
        <div>
          <StyledLabel>
            Number of best seats desired:
          </StyledLabel>
          <input
            name="seats_quantity"
            type="number"
            ref={register({ required: true, min: 1 })}
          />
          {
            errors.seats_quantity && errors.seats_quantity.type === "required" &&
            <StyledText>This is required</StyledText>
          }
          {
            errors.seats_quantity && errors.seats_quantity.type === "min" &&
            <StyledText>Needs number >= 1</StyledText>
          }
        </div>
        <div>
          Grouped?
          <input
            name="group_seats"
            type="checkbox"
            ref={register()}
          />
        </div>
        <StyledButton value="Find!" type="submit" />
      </form>
      <ReloadButton onClick={() => window.location.reload(false)}>
        Create new Venue
      </ReloadButton>
    </MainDiv>
  )
}

StyledLabel.displayName = "StyledLabel";
StyledButton.displayName = "StyledButton";
export default BestSeatsForm;
