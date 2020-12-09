// modules
import React from 'react'
//components
import { HeaderContainer } from '../Header/Header'
import { ContentListContainer } from '../ContentList/ContentList'
import { RedirectRequest } from '../../Utils/RedirectRequest'

export default function MainPageContainer(props) {
  const redirect = RedirectRequest()

  return redirect ? redirect : <MainPage /> 
}

function MainPage(props) {
  return (
    <div className='main-page'>
      <HeaderContainer />
      <ContentListContainer numPosts={10}/>
    </div>
  )
}
