import React, { Component } from "react";
import { useState, useEffect } from 'react';
import "./content.css";

const API = "./content";

export default function Content() {
  const [data, setData] = useState({content: []});

  useEffect(() => {
    const fetchData = async () => {
      const result = fetch(API)
        .then(response => response.json())
        .then(data => {
          console.log(data)
          setData({content: data.text});
        });
    }
    fetchData();
    console.log(data)
  }, [])

  console.log(data)
  console.log(data.content)

  let c = [];
  for (var i = 1; i <= 6; i++) {
    c.push(
      <p className="item" id="{i}">
        {" "}
        {data.content}{" "}
      </p>
    );
  }
  console.log("c: ", c)
  return c;
}