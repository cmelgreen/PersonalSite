import React, { Component } from "react";
import { useState, useEffect } from 'react';
import "./content.css";

const API = "./content";

export default function Content() {
  const [data, setData] = useState({content: []});

  useEffect(() => {
    const fetchData = async () => {
      const result = fetch(API)
        .then(response => response[0].json())
        .then(data => {
          console.log(data)
          setData({content: data.text});
        });
    }
    fetchData();
  }, [])

  let c = [];
  for (var i = 1; i <= 6; i++) {
    c.push(
      <p className="item" id={i}>
        {" "}
        {data.content}{" "}
      </p>
    );
  }
  return <div className="content">{c}</div>;
}