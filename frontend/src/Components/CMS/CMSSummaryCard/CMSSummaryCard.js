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
        <CardHeader title={props.post.title} />
          <CardContent>
            <Typography color="textSecondary">
              {props.post.summary}
            </Typography>
          </CardContent>
      </Card>
    </div>
  )
}