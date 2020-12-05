import React from 'react'

import { Grid } from '@material-ui/core'

import { usePostSummaries } from '../../../Utils/ContentAPI'
import CMSSummaryCard from '../CMSSummaryCard/CMSSummaryCard'

import './CMSCardList.css'

export default function CMSPostList(props) {
  const posts = usePostSummaries()
  
  return (
    <div className="cms-card-list">
      <Grid container direction="column">
          {posts.map((post, id) => (
            <Grid item xs={12} sm={12} lg={6}>
              <CMSSummaryCard id={id} post={post} />
            </Grid>
          ))}
      </Grid>
    </div>
  )
}