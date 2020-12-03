import React from 'react'

import { useEffect } from 'react'
import { useSelector, useDispatch, shallowEqual } from 'react-redux' 
import axios from 'axios'

import './ContentList.css'

import { ContentCardContainer } from '../ContentCard/ContentCard.js'
import { fetchPostSummaries } from '../../Utils/ContentAPI'
import { setContent, setSummaries } from '../../Store/Actions'

import { Grid } from '@material-ui/core'

export function ContentListContainer(props) {
  const posts = useSelector(state => state.summaries, shallowEqual)
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get('/api/post-summaries')
      .then(resp => {
        console.log(resp.data.posts)
        dispatch(setSummaries(resp.data.posts))
        console.log("Summaries are set to: ", posts)
      })
      .catch(e => {
        console.log('error fething summaries: ', e)
        dispatch(setContent(''))
      })
  }, [])

  dispatch(setContent(['test1', 'test2', 'test3']))

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
