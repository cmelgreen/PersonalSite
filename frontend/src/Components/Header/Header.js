import React from "react"

import { Link } from "react-router-dom";

import { 
  AppBar, 
  IconButton,
  Toolbar, 
  Typography,
  } from "@material-ui/core"

import MenuIcon from '@material-ui/icons/Menu';
import LinkedInIcon from '@material-ui/icons/LinkedIn';
import GithubIcon from '@material-ui/icons/Github';

export function HeaderContainer(props) {
  const link = "/"
  const text = "Cooper Melgreen"
  return <Header {...props} text={text} link={link}/>
}

function Header(props) {
  return (
    <div className="header">
    <AppBar position="static" >
      <Toolbar>
      <IconButton edge="start" aria-label="menu">
        <Link to={props.link}>
         <MenuIcon />
        </Link>
      </IconButton>
        <Typography variant="h6">
          {props.text}
        </Typography>
      <IconButton edge="end">
        <LinkedInIcon />
      </IconButton>
      <IconButton edge="end">
        <GithubIcon />  
      </IconButton>
      </Toolbar>
    </AppBar>
    </div>
  )
}
