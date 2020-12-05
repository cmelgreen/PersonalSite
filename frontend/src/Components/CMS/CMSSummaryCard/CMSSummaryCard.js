import React from 'react'

import {
  Card,
  CardActions,
  CardContent,
  CardHeader,
  CardActionArea,
  Typography,
} from "@material-ui/core";

import './CMSSummaryCard.css'

export default function CMSSummaryCard(props) {
  return (
    <div className="cms-summary-card">
      <Card>
        {props.post.summary}
      </Card>
    </div>
  )
}