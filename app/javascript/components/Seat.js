import React, { useState } from "react";
import styled from "styled-components";
import _ from "lodash";

const SeatDiv = styled.div`
  cursor: pointer;
  width: 35px;
  height: 50px;
  border-radius: 7px;
  background: linear-gradient(to top, #761818, #B54041,  #F3686A);
  margin-bottom: 10px;
  transform: skew(10deg);
  margin-top: -32px;
  box-shadow: 0 0 5px #00000080;

  &:hover:before {
    content: '';
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    background: #00000080;
    border-radius: 7px;
  }

  &.active:before {
    content: '';
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    background: #FFFFFF99;
    border-radius: 7px;
  }

  &.active.best-seat:before {
    background: #17E81499;
  }
`

const Seat = ({
  availableSeats,
  bestSeats,
  column,
  row,
  setAvailableSeats,
  venueId
}) => {
  const [selected, setSelected] = useState(false);
  const letter = String.fromCharCode(65 + (row - 1));
  const seatParams = { row: letter, column };

  const changeAvailableSeats = () => {
    if (selected) {
      var remainSeats = availableSeats.filter(seat => !_.isEqual(seat, seatParams))
      setAvailableSeats(remainSeats);
    } else {
      setAvailableSeats(availableSeats => [...availableSeats, seatParams]);
    }

    setSelected(!selected);
  }

  const handleClick = () => {
    !venueId && changeAvailableSeats()
  }

  const selectClasses = () => {
    if (selected) {
      var baseClass = "active ";
      var isBestSeat = bestSeats.some(seat => (seat.row == row && seat.column == column));
      var bestSeatClass = isBestSeat ? "best-seat" : "";

      return baseClass + bestSeatClass;
    }
  }

  return(
    <SeatDiv className={selectClasses()} onClick={handleClick}/>
  )
}

export default Seat;
