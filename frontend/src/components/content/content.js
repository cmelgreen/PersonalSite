import React from "react";
import "./content.css"

// const l = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export default function Contenct() {
  const items = GetContent()
  return (
    <div className="content">
      {items}
    </div>
  )
}

function GetContent() {
  let l = ""
  fetch("./content")
    .then( response => {
      console.log(response)
      response.json()
        .then(data => 
          {
            console.log(data)
            l = data
          }
        )
    })

  var c = []
  console.log(l)
  for (var i = 1; i <= 6; i++) {
    c.push(<p className="item" id={i}> {l} </p>);
  }
  console.log(c)
  return c
}
