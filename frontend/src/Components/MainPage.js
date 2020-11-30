import React from 'react'
import { HeaderContainer } from './Header'
import { ContentListContainer } from './ContentList/ContentList'
import { RedirectRequest } from '../Utils/RedirectRequest'

export default function MainPageContainer(props) {
  const redirect = RedirectRequest()
  return redirect ? redirect : <MainPage /> 
}

function MainPage(props) {
  return (
    <div className='main-page'>
      <HeaderContainer />
      <ContentListContainer />
    </div>
  );
}