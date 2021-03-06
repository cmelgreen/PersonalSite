import React from 'react'

import './ContentList.css'

import { ContentCardContainer } from '../ContentCard/ContentCard'
import { usePostSummaries } from '../../Utils/ContentAPI'

import { Grid } from '@material-ui/core'

export function ContentListContainer(props) {
  const posts = usePostSummaries(props.numPosts)

  return <ContentList posts={posts} />
}

function ContentList(props) {
  return  (
    <div className='content-list'>
      <Grid container >
        {props.posts.map((post, id) => 
          <Grid item xs={12} sm={12} lg={6}>
            <ContentCardContainer 
              key={id} 
              id={id} 
              title={post.title} 
              summary={post.summary} 
              link={'post/' + post.title} 
            />
          </Grid>
        )}
      </Grid>
    </div>
  )
}
