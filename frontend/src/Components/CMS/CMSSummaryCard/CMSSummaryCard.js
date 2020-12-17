import React from 'react'

import { Link } from "react-router-dom";

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
        <CardActionArea className={"cardActionArea"} component={Link} to={props.link}>
            <CardHeader title={props.post.title} />
            <CardContent>
                <Typography color="textSecondary">
                {props.post.summary}
                </Typography>
            </CardContent>
        </ CardActionArea>
      </Card>
    </div>
  )
}