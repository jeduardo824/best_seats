import React from "react";
import Venue from "./Venue";
import styled from "styled-components";

const MainDiv = styled.div`
  width: 100%;
  height: 100%;
  display: block;
`

const TitleDiv = styled.div`
  display: flex;
  justify-content: center;
`

const StyledTitle = styled.h1`
  color: #C94949;
`

const App = () => {
  return(
    <MainDiv>
      <TitleDiv>
        <StyledTitle>Best Seats App</StyledTitle>
      </TitleDiv>
      <Venue />
    </MainDiv>
  )
}

StyledTitle.displayName = "StyledTitle";
export default App;
