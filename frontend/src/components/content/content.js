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
          setData({content: data});
        });
    }
    fetchData();
  }, [])

  let c = [];
  for (var i = 1; i <= 6; i++) {
    c.push(
      <p className="item" key="{i}" id="{i}">
        {" "}
        {data.text}{" "}
      </p>
    );
  }
  return c;
}