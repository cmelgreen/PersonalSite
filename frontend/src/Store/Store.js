import { createStore } from 'redux'

import newPost from "../Models/Post"

const initialValue = {summaries: [], post: NewPost()}

const valueReducer = (state = initialValue, action) => {
  switch (action.type) {
    case 'SET_CONTENT':
      return {...state,  content: action.content}
    case 'SET_SUMMARIES':
      return {...state, summaries: action.summaries}
    default:
      return state;
  }
}

export default function Store() {
  return createStore(valueReducer)
}