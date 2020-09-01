import React, { useState } from "react";
import styled from "styled-components";
import _ from "lodash";
import SeatsSelector from "./SeatsSelector";
import VenueForm from "./VenueForm";

const MainDiv = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
`

const Venue = () => {
  const [params, setParams] = useState({});

  return(
    <MainDiv>
      { _.isEmpty(params) ?
        <VenueForm setParams={setParams} /> :
        <SeatsSelector params={params} />
      }
    </MainDiv>
  )
}

export default Venue;
