import { createStore } from 'redux';

const initialValue = { content: '', validIds: ['AAA', 'BBB', 'CCC'] };

const valueReducer = (state = initialValue, action) => {
  switch (action.type) {
    case 'SET_CONTENT':
      return {...state,  content: action.content};
    default:
      return state;
  }
};

export default function Store() {
  return createStore(valueReducer);
}