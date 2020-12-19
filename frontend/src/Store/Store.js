import { createStore } from 'redux'

import { NewPost, NewSummary } from "../Models/Posts"

const initialValue = {summaries: [], post: NewPost()}

const valueReducer = (state = initialValue, action) => {
  console.log(action)
  switch (action.type) {
    case 'SET_POST':
      return {...state, post: action.post}
    case 'SET_SUMMARIES':
      return {...state, summaries: action.summaries}
    default:
      return state;
  }
}

export default function Store() {
  return createStore(valueReducer)
}