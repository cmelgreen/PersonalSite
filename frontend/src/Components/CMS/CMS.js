import React from 'react'

import Editor from './Editor'
import CMSCardList from './CMSCardList'

import './CMS.css'

export default function CMS(props) {
  return (
    <div className="cms">
      <CMSCardList />
      <Editor />
    </div>
  )
}