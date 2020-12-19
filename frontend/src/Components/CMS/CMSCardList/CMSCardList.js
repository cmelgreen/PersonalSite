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
          <Grid item xs={12} sm={12} lg={6}>
            <CMSSummaryCard
              key={0}
              post={{title: "New Post", summary: "Create new post"}}
              link={'/cms/'}
            />
          </Grid>
          {posts.map((post, id) => (
            <Grid item xs={12} sm={12} lg={6}>
              <CMSSummaryCard 
                key={id+1} 
                post={post} 
                link={'/cms/' + post.title} 
                />
            </Grid>
          ))}
      </Grid>
    </div>
  )
}