import React from 'react'

import { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux' 
import axios from 'axios'

import './ContentList.css'

import { ContentCardContainer } from '../ContentCard/ContentCard.js'
import { setSummaries } from '../../Store/Actions'

import { Grid } from '@material-ui/core'

export function ContentListContainer(props) {
  const posts = useSelector(state => state.summaries)
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get('/api/post-summaries')
      .then(resp => dispatch(setSummaries(resp.data.posts)))
      .catch(() => dispatch(setSummaries([])) )
  }, [])

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
          </Grid>)
        }
      </Grid>
    </div>
  )
}
