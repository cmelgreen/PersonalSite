import React from "react";

import "./ContentCard.css"

import { Link } from "react-router-dom";

import {
  Card,
  CardActions,
  CardContent,
  CardHeader,
  CardActionArea,
  Typography,
} from "@material-ui/core";


export function ContentCardContainer(props) {
  return <ContentCard {...props} />
}

function ContentCard(props) {
  return (
    <Card className="content-card" >
      <CardActionArea className={"cardActionArea"} component={Link} to={props.link}>
          <CardHeader title={props.title} />
          <CardContent>
            <Typography color="textSecondary">
              {props.summary}
            </Typography>
          </CardContent>
          <CardActions />
    </CardActionArea>
   </Card>
  )
}