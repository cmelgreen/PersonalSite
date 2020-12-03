import { createStore } from 'redux'

const initialValue = {summaries: []}

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