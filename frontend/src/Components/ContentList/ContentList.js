import React from "react"
import { useSelector } from "react-redux"

import "./ContentList.css"

import { ContentCardContainer } from "../ContentCard/ContentCard.js"

import { Grid } from '@material-ui/core'

export function ContentListContainer(props) {
  const content = useSelector((state) => state.validIds)

  const cards = content.map((id, i) => (
      <ContentCardContainer key={i} id={id} text={id} link={"post/" + id} />
    ))

  return <ContentList cards={cards} />
}

function ContentList(props) {

  return  (
    <div className="content-list">
      <Grid container >
        {props.cards.map(card => (
          <Grid item xs={12} sm={12} lg={6}>
            {card}
          </Grid>
        ))}
      </Grid>
    </div>
  )
}
