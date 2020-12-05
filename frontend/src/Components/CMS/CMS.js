import React from 'react'

import Editor from './Editor/Editor'
import CMSCardList from './CMSCardList/CMSCardList'

import './CMS.css'

export default function CMS(props) {
  return (
    <div className="cms">
      <CMSCardList />
      <Editor />
    </div>
  )
}