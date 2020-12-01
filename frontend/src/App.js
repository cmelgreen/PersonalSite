import React from 'react';
import { Provider } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Store from './Store/Store';
import './App.css'

import  ParseRoutes from './Utils/ParseRoutes'
import { routes } from './routes.json'

export default function AppContainer() {
  return (
    <Provider store={Store()}>
      <Router>
          {ParseRoutes(routes).map((props, i) => <Route key={i} {...props} />)}
      </Router>
    </Provider>
  )
}
