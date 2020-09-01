import React, { useState } from "react";
import styled from "styled-components";
import { useForm } from "react-hook-form";

const StyledLabel = styled.label`
  color: #F3F7F0;
  margin: 5px 0;
`

const StyledText = styled.p`
  color: #C94949;
  margin: 4px 0;
`

const StyledButton = styled.input`
  margin: 10px 18%;
`

const VenueForm = ({ setParams }) => {
  const { register, handleSubmit, errors } = useForm();
  const onSubmit = (data) => {
    setParams(data);
  }

  return(
    <div>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div>
          <StyledLabel>
            Venue Title:
          </StyledLabel>
          <input
            name="title"
            type="text"
            ref={register({ required: true })}
          />
          {errors.title && <StyledText>This is required</StyledText>}
        </div>
        <div>
          <StyledLabel>
            Rows:
          </StyledLabel>
          <input
            name="rows"
            type="number"
            ref={register({ required: true, min: 1 })}
          />
          {
            errors.rows && errors.rows.type === "required" &&
            <StyledText>This is required</StyledText>
          }
          {
            errors.rows && errors.rows.type === "min" &&
            <StyledText>Needs number >= 1</StyledText>
          }
        </div>
        <div>
          <StyledLabel>
            Columns:
          </StyledLabel>
          <input
            name="columns"
            type="number"
            ref={register({ required: true, min: 1 })}
          />
        </div>
        {
          errors.columns && errors.columns.type === "required" &&
          <StyledText>This is required</StyledText>
        }
        {
          errors.columns && errors.columns.type === "min" &&
          <StyledText>Needs number >= 1</StyledText>
        }
        <StyledButton value="Render Seats" type="submit" />
      </form>
    </div>
  )
}

export default VenueForm;
