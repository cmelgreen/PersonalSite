import { createStore } from 'redux';

const initialValue = { summaries: [], validIds: ['AAA', 'BBB', 'CCC'] };

const valueReducer = (state = initialValue, action) => {
  switch (action.type) {
    case 'SET_CONTENT':
      return {...state,  content: action.content};
    case 'SET_SUMMARIES':
      console.log("Setting summaries")
      return {...state, summaries: action.summaries}
    default:
      return state;
  }
};

export default function Store() {
  return createStore(valueReducer);
}