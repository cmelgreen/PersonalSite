import React from 'react'

import { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux' 

import './ContentList.css'

import { ContentCardContainer } from '../ContentCard/ContentCard.js'
import { fetchPostSummaries } from '../../Utils/ContentAPI'

import { Grid } from '@material-ui/core'

export function ContentListContainer(props) {
  const posts = useSelector(state => state.summaries)
  const dispatch = useDispatch()

  useEffect(() => {
    dispatch(setSummaries(fetchPostSummaries()))
  }, [])

  return <ContentList posts={posts} />
}

function ContentList(props) {
  return  (
    <div className='content-list'>
      <Grid container >
        {props.posts.map((id, post) => (
          <Grid item xs={12} sm={12} lg={6}>
            <ContentCardContainer 
              key={id} 
              id={id} 
              title={post.title} 
              summary={post.summary} 
              link={'post/' + post.title} 
            />
          </Grid>
        ))}
      </Grid>
    </div>
  )
}
