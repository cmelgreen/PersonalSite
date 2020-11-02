import React, { Component } from "react";
import { useState, useEffect } from 'react';
import "./content.css";

const API = "./content"

class Content extends Component {
  constructor(props) {
    this.state = {content: ""};
  }

  componentDidMount() {
    fetch("./content")
      .then(response => response.json)
      .then(data => this.setState({
        content: data.text
      }))
  }

  render() {
    const content = this.state;

    let c = [];
    for (var i = 1; i <= 6; i++) {
      c.push(
        <p className="item" key="{i}" id="{i}">
          {" "}
          {content.text}{" "}
        </p>
      );
    }
    return c;

  }
}


export default Content;