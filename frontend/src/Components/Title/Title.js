import React from "react"
import "./Title.css"

export default function TitleContainer() {
  return <Title />
}

function Title(props) {
  return (
    <div className="title">
      <picture>
        <img className="icon" src={"/icon"} alt="icon" />
      </picture>
      <div className="name">Cooper Melgreen </div>
    </div>
  )
}