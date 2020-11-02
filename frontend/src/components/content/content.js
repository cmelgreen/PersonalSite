import React from "react";
import "./content.css"

// const l = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export default function Content() {
  let c = [];
  fetch(
    "http://tf-lb-2020110217295736020000000b-971054050.us-west-2.elb.amazonaws.com/content"
  ).then((response) => {
    console.log(response);
    response.json().then((data) => {
      c = formatData(data);
    });
  });

  return <div className="content">{c}</div>;
}

function formatData(data) {
  var c = [];
  console.log(data);
  for (var i = 1; i <= 6; i++) {
    c.push(
      <p className="item" key="{i}" id="{i}">
        {" "}
        {data.text}{" "}
      </p>
    );
  }
  console.log(c);
  return c;
}
