
import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { setPost, setSummaries } from '../Store/Actions'
import axios from 'axios'

import { NewPost } from '../Models/Posts'

const apiRoot = '/api'
const apiPost = apiRoot + '/post'
const apiPostSummaries = apiRoot + '/post-summaries'

export const usePostByID = (id, raw=false) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPost, {params: {id, raw}})
      .then(resp => {if ( resp.data ) dispatch(setPost(resp.data))})
      .catch(() => dispatch(setPost(NewPost())))
    
      return () => dispatch(setPost(NewPost()))
  }, [id])

  return useSelector(state => state.post)
}

export const createPost = (title, summary, data, tags) => {
  const post = {title: title, summary: summary, content: data}
  axios.post(apiPost, post)
    .then(resp => console.log('Created', resp))
    .catch(resp => console.log('Error creating post', resp))
}

export const updatePost = (id, title, summary, data, tags) => {
  const post = {id: id, title: title, summary: summary, content: data}

  axios.put(apiPost, post)
    .then(resp => console.log('Updated', resp))
    .catch(resp => console.log('Error updating post', resp))
}

export const deletePost = (id) => {
  console.log('deleting: ', id)
  axios.delete(apiPost, {params: {id}})
    .then(resp => console.log(resp))
    .catch(resp => console.log(resp))
}

export const usePostSummaries = (numPosts=-1, dependsOn) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPostSummaries, {params: {numPosts}})
      .then(resp => {if ( resp.data.posts ) dispatch(setSummaries(resp.data.posts))})
      .catch(() => dispatch(setSummaries([])))
  }, [dependsOn])

  return useSelector(state => state.summaries)
}

export const updatePostSummaries = () => {
  const dispatch = useDispatch()

  axios.get(apiPostSummaries)
    .then(resp => dispatch(setSummaries(resp.data.posts)))
    .catch(() => dispatch(setSummaries([])))
}